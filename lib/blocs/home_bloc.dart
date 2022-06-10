import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_political_bias_detector/extensions.dart';
import 'package:rxdart/subjects.dart';
import 'package:http/http.dart' as http;

class HomeBloc {
  Stream<ButtonState> get buttonState => _buttonStateController.stream;
  Stream<Result> get result => _resultController.stream;

  final _buttonStateController = BehaviorSubject<ButtonState>();
  final _resultController = PublishSubject<Result>();

  void predict(String text) async {
    _buttonStateController.add(ButtonState.loading);

    // final response = await http.post(
    //   Uri.parse('https://tfg-ssm.herokuapp.com/predict'),
    //   headers: <String, String>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //   },
    //   body: jsonEncode(<String, String>{
    //     'input_text': text,
    //   }),
    // );

    // if (response.statusCode == 200) _restulController.add(Result.fromJson(jsonDecode(response.body)));

    await Future.delayed(const Duration(seconds: 1));
    _resultController.add(_processResult(_result));

    _buttonStateController.add(ButtonState.iddle);
  }

  Result _processResult(Result result) {
    final List<String> tokens = result.text.split(' ');
    final List<double> attention = List.from(result.attention);

    // Eliminar xxbos
    tokens.removeAt(0);
    attention.removeAt(0);

    final List<int> xxmajIndices = [], xxupIndices = [];
    for (var i = 0; i < tokens.length; i++) {
      switch (tokens[i]) {
        case 'xxunk':
          tokens[i] = '_';
          break;
        case 'xxmaj':
          if (tokens[i + 1] != 'xxunk') {
            tokens[i + 1] = tokens[i + 1].capitalize();
          }
          xxmajIndices.add(i);
          break;
        case 'xxup':
          tokens[i + 1] = tokens[i + 1].toUpperCase();
          xxupIndices.add(i);
          break;
        default:
      }
    }

    for (var i = 0; i < xxmajIndices.length; i++) {
      var index = xxmajIndices[i] - i;

      tokens.removeAt(index);
      attention.removeAt(index);
    }
    for (var i = 0; i < xxupIndices.length; i++) {
      var index = xxupIndices[i] - i - xxmajIndices.length;

      tokens.removeAt(index);
      attention.removeAt(index);
    }

    return Result(attention: attention, text: tokens.join(' '), predictions: result.predictions);
  }

  void dispose() {
    _buttonStateController.close();
  }
}

class Result {
  final List<double> attention;
  final String text;
  final Map<String, double> predictions;

  const Result({
    @required this.attention,
    @required this.text,
    @required this.predictions,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        attention: json['attention'],
        text: json['text'],
        predictions: Map.from(json['preds']),
      );
}

enum ButtonState { iddle, loading }

Result _result = const Result(
    attention: [
      0.02542262151837349,
      0.01463250070810318,
      0.07837411016225815,
      0.20266078412532806,
      0.02088632434606552,
      0.01777963526546955,
      0.014747501350939274,
      0.03246026486158371,
      0.00824799295514822,
      0.016839804127812386,
      0.0031973468139767647,
      0.012320518493652344,
      0.030204910784959793,
      0.04066576808691025,
      0.012793471105396748,
      0.030719585716724396,
      0.012349291704595089,
      0.011810004711151123,
      0.02944338507950306,
      0.02542402595281601,
      0.07020679116249084,
      0.04480287805199623,
      0.01722995936870575,
      0.041041627526283264,
      0.014046154916286469,
      0.03179727494716644,
      0.003500147722661495,
      0.009875648654997349,
      0.017929013818502426,
      0.011400352232158184,
      0.03346748277544975,
      0.034535687416791916,
      0.01620473898947239,
      0.020664043724536896,
      0.02579403482377529,
      0.009205342270433903,
      0.0029033333994448185,
      0.013698140159249306,
      0.03475985676050186,
      0.012073587626218796,
      0.02868298627436161,
      0.010550444014370441,
      0.027688931673765182,
      0.011033741757273674,
      0.027492402121424675,
      0.00342398788779974,
      0.009820028208196163,
      0.02222452312707901,
      0.036201007664203644,
      0.091875359416008,
      0.09219817072153091,
      0.009430418722331524,
      0.017917683348059654,
      0.05157828330993652,
      0.016098402440547943,
      0.023990526795387268,
      0.013388017192482948,
      0.03378339856863022,
      0.029002761468291283,
      0.00814832467585802,
      0.03793053701519966,
      0.09391225874423981,
      0.006094123236835003,
      0.02213180623948574,
      0.054761648178100586,
      0.032801732420921326,
      0.0316886305809021,
      0.001722472719848156,
      0.022167257964611053,
      0.05188387259840965,
      0.012774793431162834,
      0.034839753061532974,
      0.018065722659230232,
      0.03925017639994621,
      0.00646304851397872,
      0.019949298352003098,
      0.043825697153806686,
      0.013860980980098248,
      0.0320785790681839,
      0.08561225980520248,
      0.08910013735294342,
      0.003764958819374442,
      0.022085856646299362,
      0.05675014480948448,
      0.011200404725968838,
      0.027198152616620064,
      0.011426679790019989,
      0.015509909950196743,
      0.014022566378116608,
      0.005814953241497278,
      0.021422745659947395,
      0.05200968682765961,
      0.010238809511065483,
      0.029501717537641525,
      0.07823320478200912,
      0.12166883051395416,
      0.04685847461223602,
      0.08180125057697296,
      0.02057020366191864,
      0.09277244657278061,
      0.2004973590373993,
      0.00790378451347351,
      0.03796546906232834,
      0.1118968278169632,
      0.0024218361359089613,
      0.004228795412927866,
      0.010008655488491058,
      0.016415048390626907,
      0.02619657851755619,
      0.06673494726419449,
      0.05250964313745499,
      0.12823964655399323,
      0.020059416070580482,
      0.007178534287959337,
      0.011852766387164593,
      0.034842610359191895,
      0.043107375502586365,
      0.04513230547308922,
      0.013456030748784542,
      0.02178313583135605,
      0.002968488959595561,
      0.015310880728065968,
      0.044640813022851944,
      0.004947400186210871,
      0.008327891118824482,
      0.004255922045558691,
      0.015395428985357285,
      0.03232539817690849,
      0.012332809157669544,
      0.005052375607192516,
      0.018021369352936745,
      0.04886845499277115,
      0.01841319352388382,
      0.049027346074581146,
      0.01240655966103077,
      0.02388470247387886,
      0.03675607219338417,
      0.0050866082310676575,
      0.0056978557258844376,
      0.04563586786389351,
      0.1167837381362915,
      0.0064420937560498714,
      0.036261484026908875,
      0.09135013818740845,
      0.0020275127608329058,
      0.006585609633475542,
      0.018902329728007317,
      0.010813646018505096,
      0.009120060130953789,
      0.019787246361374855,
      0.013689748011529446,
      0.005799458362162113,
      0.026351947337388992,
      0.06698424369096756,
      0.024880301207304,
      0.05612170323729515,
      0.030149083584547043,
      0.0744975209236145,
      0.04877525568008423,
      0.12506747245788574,
      0.04486386850476265,
      0.12176652252674103,
      0.005504302680492401,
      0.027107907459139824,
      0.05830030515789986,
      0.0052597904577851295,
      0.009391185827553272,
      0.017141737043857574,
      0.03738560527563095,
      0.09917908906936646,
      0.08482341468334198,
      0.02721247635781765,
      0.06743919104337692,
      0.062035996466875076,
      0.015875190496444702,
      0.08934745192527771,
      0.22985833883285522,
      0.09930259734392166,
      0.022459527477622032,
      0.08738476037979126,
      0.22761790454387665,
      0.010059699416160583,
      0.014538070186972618,
      0.03610554337501526,
      0.0404825359582901,
      0.02898499369621277,
      0.06665222346782684,
      0.002620205981656909,
      0.015359926037490368,
      0.037661489099264145,
      0.011822082102298737,
      0.028546277433633804,
      0.008963176049292088,
      0.021699273958802223,
      0.003064971650019288,
      0.002251730067655444,
      0.013454136438667774,
      0.036474764347076416,
      0.012409113347530365,
      0.03142405301332474,
      0.044468384236097336,
      0.002058387501165271,
      0.019602667540311813,
      0.05472716689109802,
      0.02825607731938362,
      0.06492763757705688,
      0.011043664067983627,
      0.024395406246185303,
      0.007383682765066624,
      0.0164021085947752,
      0.00436583673581481,
      0.01270062942057848,
      0.026628784835338593,
      0.023006252944469452,
      0.023698048666119576,
      0.016356412321329117,
      0.01860138773918152,
      0.015360917896032333,
      0.03955339640378952,
      0.008422371000051498,
      0.017674371600151062,
      0.038473520427942276,
      0.004225475713610649,
      0.04021536186337471,
      0.09882839024066925,
      0.004368190187960863,
      0.007237013895064592,
      0.034705858677625656,
      0.10540460050106049,
      0.06799373030662537,
      0.03747047856450081,
      0.10154169797897339,
      0.026324350386857986,
      0.06193862855434418,
      0.08125390112400055,
      0.059757959097623825,
      0.4379643499851227,
      1.0,
      0.0636436864733696,
      0.09011968225240707,
      0.011172229424118996,
      0.028429891914129257,
      0.015802208334207535,
      0.04668598622083664,
      0.0012035382678732276,
      0.014792845584452152,
      0.032884661108255386,
      0.006650710012763739,
      0.025952329859137535,
      0.05752243101596832,
      0.010613305494189262,
      0.02239261381328106,
      0.016252391040325165,
      0.0035517383366823196,
      0.03705152869224548,
      0.10832919925451279,
      0.05950090289115906,
      0.155979186296463,
      0.014801588840782642,
      0.03516228124499321,
      0.02763192541897297,
      0.05111316591501236,
      0.005615180358290672,
      0.013601836748421192,
      0.011899546720087528,
      0.016095004975795746,
      0.04712427780032158,
      0.009973814710974693,
      0.02343236654996872,
      0.0024128733202815056,
      0.005845504812896252,
      0.010431637987494469,
      0.004517245106399059,
      0.006967054679989815,
      0.04052656516432762,
      0.08263617008924484,
      0.004905947484076023,
      0.007621051277965307,
      0.02213049866259098,
      0.05821334198117256,
      0.002202272415161133,
      0.012085819616913795,
      0.03073706477880478,
      0.008806905709207058,
      0.036317840218544006,
      0.11010779440402985,
      0.09137576073408127,
      0.29777950048446655,
      0.02158186212182045,
      0.03747723996639252,
      0.007744333706796169,
      0.014854690060019493,
      0.023023970425128937,
      0.0471988320350647,
      0.026833223178982735,
      0.0665048360824585,
      0.039254698902368546,
      0.09817960113286972,
      0.023626815527677536,
      0.05418681353330612,
      0.020111655816435814,
      0.19078317284584045,
      0.41925597190856934,
      0.011820865795016289,
      0.018777478486299515,
      0.01616337150335312,
      0.0779510959982872,
      0.18378326296806335,
      0.11991088837385178,
      0.2969522774219513,
      0.13912250101566315,
      0.367729127407074,
      0.015395354479551315,
      0.034118592739105225,
      0.07996150106191635,
      0.006940044928342104,
      0.018819283694028854,
      0.018781021237373352,
      0.008772430010139942,
      0.019326994195580482,
      0.01611490361392498,
      0.04498239606618881,
      0.011051731184124947,
      0.01640227437019348,
      0.021570712327957153,
      0.05119970068335533,
      0.00954331923276186,
      0.007880709134042263,
      0.013278478756546974,
      0.0017003254033625126,
      0.001411066041328013,
      0.018204258754849434,
      0.057170432060956955,
      0.010524849407374859,
      0.027418289333581924,
      0.0432276614010334,
      0.05252378433942795,
      0.11352424323558807,
      0.033018119633197784,
      0.04269588738679886,
      0.09063359349966049,
      0.008767206221818924,
      0.019857753068208694,
      0.03673260286450386,
      0.022869719192385674,
      0.05688953772187233,
      0.06623707711696625,
      0.005382918287068605,
      0.016488688066601753,
      0.047532591968774796,
      0.0059171984903514385,
      0.0037027259822934866,
      0.01023967657238245,
      0.01524399220943451,
      0.024295978248119354,
      0.057027075439691544,
      0.00719371996819973,
      0.022506440058350563,
      0.04791318252682686,
      0.036919932812452316,
      0.0883699283003807,
      0.011591609567403793,
      0.025167619809508324,
      0.010153471492230892,
      0.07152418047189713,
      0.1695844531059265,
      0.16642507910728455,
      0.45696356892585754,
      0.004956396762281656,
      0.030124390497803688,
      0.08419699221849442,
      0.01865706406533718,
      0.047099608927965164,
      0.03310195356607437,
      0.0461333803832531,
      0.008623210713267326,
      0.009921195916831493,
      0.013822809793055058,
      0.0051887305453419685,
      0.003349195932969451,
      0.005260510370135307,
      0.009100547060370445,
      0.023291276767849922,
      0.031167814508080482,
      0.09914471209049225,
      0.003824090352281928,
      0.028079360723495483,
      0.06346790492534637,
      0.03111845627427101,
      0.058465808629989624,
      0.008187350817024708,
      0.015953825786709785,
      0.014613291248679161,
      0.024305714294314384,
      0.013198623433709145,
      0.031173575669527054,
      0.09270196408033371,
      0.00604257732629776,
      0.038550592958927155,
      0.10674729943275452,
      0.006276656873524189,
      0.012547668069601059,
      0.011796699836850166,
      0.02596369758248329,
      0.010347381234169006,
      0.026862189173698425,
      0.0035564128775149584,
      0.013086020946502686,
      0.029451724141836166,
      0.003725501475855708,
      0.014969857409596443,
      0.03800717368721962,
      0.035602960735559464,
      0.015595794655382633,
      0.06307417154312134,
      0.13948048651218414,
      0.008539056405425072,
      0.022692430764436722,
      0.05364063009619713,
      0.011014251038432121,
      0.02704736217856407,
      0.01240016520023346,
      0.02202707901597023,
      0.055079467594623566,
      0.011876363307237625,
      0.03125113993883133,
      0.03768279775977135,
      0.021765705198049545,
      0.04961971566081047,
      0.012318768538534641,
      0.19000598788261414,
      0.5508334636688232,
      0.0134124169126153,
      0.03146889805793762,
      0.03207086771726608,
      0.025418346747756004,
      0.0046313307248055935,
      0.018014507368206978,
      0.12211541831493378,
      0.31183943152427673,
      0.18576906621456146,
      0.4452456831932068,
      0.003026645164936781,
      0.0070936414413154125,
      0.011788519099354744,
      0.04200280085206032,
      0.09673891216516495,
      0.04601341485977173,
      0.1526288241147995,
      0.005433544050902128,
      0.04492438584566116,
      0.15014870464801788,
      0.019726799800992012,
      0.09399306774139404,
      0.23401977121829987,
      0.14390826225280762,
      0.373769074678421,
      0.001449786126613617,
      0.007163939997553825,
      0.023953113704919815,
      0.061114415526390076,
      0.05090556666254997,
      0.003602846059948206,
      0.03590557724237442,
      0.10032419115304947,
      0.18774166703224182,
      0.003136127255856991,
      0.03511999547481537,
      0.0921441912651062,
      0.004162539727985859,
      0.018826955929398537,
      0.04421316087245941,
      0.03949113190174103,
      0.005474884528666735,
      0.027472319081425667,
      0.058529116213321686,
      0.027461687102913857,
      0.008221032097935677,
      0.028902603313326836,
      0.06868166476488113,
      0.10807295143604279,
      0.28794097900390625,
      0.0764208734035492,
      0.07353128492832184,
      0.0031288298778235912,
      0.022877465933561325,
      0.05588876083493233,
      0.02938290312886238,
      0.03172406181693077,
      0.02775527536869049,
      0.00477716326713562,
      0.03603237494826317,
      0.07134415954351425,
      0.032383162528276443,
      0.07309020310640335,
      0.0031921740155667067,
      0.04701634868979454,
      0.12109740823507309,
      0.0020677580032497644,
      0.007272743154317141,
      0.013103182427585125,
      0.0013080943608656526,
      0.007511625066399574,
      0.017051635310053825,
      0.0029349925462156534,
      0.0067549399100244045,
      0.016936399042606354,
      0.01795988157391548,
      0.0037267711013555527,
      0.00620212871581316,
      0.012483501806855202,
      0.022397911176085472,
      0.03221920132637024,
      0.006855465937405825,
      0.021687379106879234,
      0.048100173473358154,
      0.003820500336587429,
      0.026359088718891144,
      0.06991782784461975,
      0.009868777357041836,
      0.023608285933732986,
      0.042387112975120544,
      0.07972582429647446,
      0.004119256976991892,
      0.00802275724709034,
      0.024510012939572334,
      0.07098641991615295,
      0.04368853196501732,
      0.2469109445810318,
      0.5599570274353027,
      0.003601243020966649,
      0.0074665723368525505,
      0.01583002135157585,
      0.02500230073928833,
      0.05084073171019554,
      0.058911584317684174,
      0.023323893547058105,
      0.05524398013949394,
      0.030978240072727203,
      0.06302443146705627,
      0.012282701209187508,
      0.12704984843730927,
      0.344269722700119,
      0.004621418192982674,
      0.06666754931211472,
      0.15832041203975677,
      0.0018964976770803332,
      0.00719870813190937,
      0.01750493235886097,
      0.0015544913476333022,
      0.002467429731041193,
      0.008410286158323288,
      0.022506432607769966,
      0.004758863244205713,
      0.010399783961474895,
      0.017093807458877563,
      0.04232223331928253,
      0.13344109058380127,
      0.02317473106086254,
      0.06697659194469452,
      0.16744372248649597,
      0.05407967418432236,
      0.012871327809989452,
      0.036152347922325134,
      0.014384130947291851,
      0.03392487391829491,
      0.0034960818011313677,
      0.013140699826180935,
      0.030124731361865997,
      0.008678705431520939,
      0.018860366195440292,
      0.0017655318370088935,
      0.006241938099265099,
      0.011440332047641277,
      0.00373417092487216,
      0.007698847912251949,
      0.004852374084293842,
      0.02400396205484867,
      0.0770183727145195,
      0.008619789034128189,
      0.032204657793045044,
      0.057597823441028595,
      0.013005530461668968,
      0.03065175749361515,
      0.0766570046544075,
      0.07803502678871155,
      0.01348838396370411,
      0.032635077834129333,
      0.02706371806561947,
      0.06758193671703339,
      0.002941629383713007,
      0.07093852758407593,
      0.20822115242481232,
      0.06295844912528992,
      0.11307784169912338,
      0.04201646149158478,
      0.0015389773761853576,
      0.0036712337750941515,
      0.023691337555646896,
      0.0540950745344162,
      0.022341569885611534,
      0.017222994938492775,
      0.040900733321905136,
      0.0020529809407889843,
      0.007880141958594322,
      0.02579193376004696,
      0.04837065190076828,
      0.015479132533073425,
      0.048514336347579956,
      0.09674488753080368,
      0.0048972065560519695,
      0.013583636842668056,
      0.039035119116306305,
      0.07566490024328232,
      0.009192408062517643,
      0.020840108394622803,
      0.05273652449250221,
      0.01519949920475483,
      0.03439157083630562,
      0.006397317163646221,
      0.023250840604305267,
      0.05669892951846123,
      0.04732263460755348,
      0.010586137883365154,
      0.040915798395872116,
      0.1277899295091629,
      0.11690854281187057,
      0.004150572698563337,
      0.055415693670511246,
      0.14510273933410645,
      0.055437907576560974,
      0.009481644257903099,
      0.016520418226718903,
      0.02928144671022892,
      0.012370073236525059,
      0.03532400727272034,
      0.046998947858810425,
      0.02474202960729599,
      0.04756380617618561,
      0.03765026479959488,
      0.08678872883319855,
      0.07043015956878662,
      0.0433088019490242,
      0.10024286806583405,
      0.20848943293094635,
      0.024132167920470238,
      0.05243973433971405,
      0.035995300859212875,
      0.00687554432079196,
      0.01243291050195694,
      0.03250352665781975,
      0.05128626897931099,
      0.017308121547102928,
      0.041569530963897705,
      0.019623158499598503,
      0.025015927851200104,
      0.08127250522375107,
      0.007720336318016052,
      0.013553359545767307,
      0.03748941048979759,
      0.10190786421298981,
      0.009009197354316711,
      0.029267162084579468,
      0.06951194256544113,
      0.003131768200546503,
      0.01415387261658907,
      0.03969910368323326,
      0.012511313892900944,
      0.015351075679063797,
      0.0207404475659132,
      0.06726694852113724,
      0.008930766955018044,
      0.023003559559583664,
      0.002614588476717472,
      0.023252340033650398,
      0.05698110908269882,
      0.026979122310876846,
      0.07101163268089294,
      0.09272628277540207,
      0.02425997145473957,
      0.062440697103738785,
      0.013125886209309101,
      0.00790464598685503,
      0.02063475176692009,
      0.0026697206776589155,
      0.008592251688241959,
      0.02103365771472454,
      0.003843517741188407,
      0.007880405522882938,
      0.009934830479323864,
      0.026572279632091522,
      0.014861633069813251,
      0.04040954262018204,
      0.0018034521490335464,
      0.016696495935320854,
      0.04533381015062332,
      0.032438721507787704,
      0.09647423774003983,
      0.0028646003920584917,
      0.07207436859607697,
      0.2394021898508072,
      0.017231836915016174,
      0.04180271923542023,
      0.01834862492978573,
      0.04699470475316048,
      0.013000267557799816,
      0.0340491384267807,
      0.004167530220001936,
      0.007595903240144253,
      0.11965274810791016,
      0.29400870203971863,
      0.0034229462035000324,
      0.009035217575728893,
      0.02181394398212433,
      0.013738459907472134,
      0.04897305369377136,
      0.1046358197927475,
      0.05379263311624527,
      0.18380151689052582,
      0.19175250828266144,
      0.03593679144978523,
      0.10956790298223495,
      0.12364242970943451,
      0.060400113463401794
    ],
    text:
        "xxbos xxmaj la frase es de xxmaj frank xxmaj xxunk , el xxunk protagonista del drama político de ficción xxmaj house of xxmaj xxunk : xxunk xxmaj el poder se parece mucho al mercado inmobiliario . xxmaj la clave es ubicación , ubicación , ubicación . xxmaj cuanto más cerca estás de la fuente de poder , más alto es el valor de tu propiedad xxunk . xxmaj la pronuncia el personaje mientras xxunk a la cámara desde la primera fila de la toma de posesión del nuevo presidente , una ubicación que le permite salir en televisión en segundo plano durante el acto y , por tanto , aumentar su valor político . xxmaj ese mismo espacio de poder en la foto , pero en el escenario real de la toma de posesión del nuevo presidente de la xxmaj junta de xxmaj castilla y xxmaj león , del xxup pp , lo ocupaba el martes xxmaj santiago xxmaj abascal , líder de xxmaj vox , la primera formación abiertamente ultraderechista con representación parlamentaria en la democracia española desde la coalición en que estuvieron integradas xxmaj falange y xxmaj fuerza xxmaj nueva en 1979 . xxmaj el líder del xxup pp , xxmaj alberto xxmaj núñez xxmaj feijóo , xxunk con una reunión perfectamente xxunk su asistencia y evitó así ser xxunk con xxmaj abascal , pero no logró ocultar que comienza una nueva etapa en la derecha española ante la composición del cuadro en xxmaj valladolid : un presidente del xxup pp , xxmaj alfonso xxmaj fernández xxmaj mañueco , jurando el cargo bajo la mirada del líder de xxmaj vox , de la presidenta de la xxmaj comunidad de xxmaj madrid , xxmaj isabel xxmaj díaz xxmaj ayuso , quien ha expresado sin reparos su disposición a colaborar con la ultraderecha , y de xxmaj mariano xxmaj rajoy , expresidente del xxup pp que pareció ocupar el lugar del viejo xxup pp en eterno viaje al centro . xxmaj la ausencia del recién xxunk nuevo jefe de todos ellos era tan clamorosa como las presencias en ese acto . xxmaj de alguna manera remite a la decisión que tomó en su día xxmaj pablo xxmaj casado de no volver a hablar de corrupción , como si lo que él no mencionaba no existiera . xxmaj feijóo parece pretender que si no está en la foto con xxmaj abascal el partido que preside no pacta con xxmaj vox . xxmaj hasta ahora , xxmaj vox ha sido juzgado por su capacidad de distorsionar el debate público y movilizar a un electorado con registros xxunk xxunk . xxmaj desde posiciones de ultraderecha , la formación ha forzado las costuras de la cultura política española heredada del bipartidismo , entre la denuncia xxunk de lo políticamente correcto , la provocación , la brocha gorda y la mala educación . xxmaj ayer se abrió otra etapa . xxmaj vox tiene ahora responsabilidad de gobierno ( la vicepresidencia y las consejerías de xxmaj empleo , xxmaj agricultura y xxmaj cultura ) . xxmaj el xxup pp , como facilitador de la coalición , se hace corresponsable de cómo se traduzca su retórica excluyente en el uso del poder ejecutivo para transformar las vidas de los ciudadanos de xxmaj castilla y xxmaj león . xxmaj la comunidad es desde ahora un laboratorio donde los españoles van a observar la conducta de xxmaj vox en contacto con el poder , pero también el comportamiento del xxup pp cuando sus socios desafían su aspiración de apelar a un centroderecha de amplio espectro . xxmaj los primeros indicios son xxunk . xxmaj ahí están las concesiones programáticas y de discurso hechas por xxmaj mañueco en asuntos como la violencia machista o la memoria histórica . xxmaj ahí está el xxmaj gobierno con menos mujeres de todas las comunidades autónomas . xxmaj vox ha dejado claro que sus consejeros hablarán con voz propia , anunciando su intención de disolver la xxmaj españa de las autonomías cuyos empleos se disponen a disfrutar . xxmaj toda xxmaj europa mira con tensión a xxmaj francia donde xxmaj xxunk xxmaj le xxmaj pen , xxunk de xxmaj abascal , disputa a xxmaj emmanuel xxmaj macron este domingo la presidencia de la xxmaj república . xxmaj aquí , xxmaj feijóo , prefiere mirar para otro lado .",
    predictions: {
      "GCUP-EC-GC": 0.20021109282970428,
      "GCs": 0.043593861162662506,
      "GP": 0.12781058251857758,
      "GS": 99.24519348144531,
      "GVOX": 0.3831901252269745
    });