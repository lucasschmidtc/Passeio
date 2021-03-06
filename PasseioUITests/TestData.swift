//
//  TestData.swift
//  PasseioUITests
//
//  Created by Lucas Cavalcante on 20/07/17.
//  Copyright © 2017 Lucas Cavalcante. All rights reserved.
//

import Foundation
import CoreLocation

struct Recorded {
    let locations: [[CLLocationCoordinate2D]]
    let date: Date
}

let rioDeJaneiro = Recorded(locations: [[CLLocationCoordinate2D(latitude: -43.17575454711914, longitude: -22.966217249658506),
                                         CLLocationCoordinate2D(latitude: -43.177428245544434, longitude: -22.967126060847377),
                                         CLLocationCoordinate2D(latitude: -43.17897319793701, longitude: -22.968074379052872),
                                         CLLocationCoordinate2D(latitude: -43.180646896362305, longitude: -22.968943664897516),
                                         CLLocationCoordinate2D(latitude: -43.18223476409912, longitude: -22.97005002061534),
                                         CLLocationCoordinate2D(latitude: -43.18382263183594, longitude: -22.971393440385093),
                                         CLLocationCoordinate2D(latitude: -43.185153007507324, longitude: -22.97257879968204),
                                         CLLocationCoordinate2D(latitude: -43.18618297576904, longitude: -22.973685125646767),
                                         CLLocationCoordinate2D(latitude: -43.18721294403076, longitude: -22.97518655354242),
                                         CLLocationCoordinate2D(latitude: -43.18802833557129, longitude: -22.976608943530483),
                                         CLLocationCoordinate2D(latitude: -43.1887149810791, longitude: -22.97826837959404),
                                         CLLocationCoordinate2D(latitude: -43.189144134521484, longitude: -22.97976975656747),
                                         CLLocationCoordinate2D(latitude: -43.189616203308105, longitude: -22.981863754484966),
                                         CLLocationCoordinate2D(latitude: -43.18970203399658, longitude: -22.983246565505034),
                                         CLLocationCoordinate2D(latitude: -43.1892728805542, longitude: -22.984313295763485)],
                                        [CLLocationCoordinate2D(latitude: -43.1947660446167, longitude: -22.988106046236318),
                                         CLLocationCoordinate2D(latitude: -43.19729804992676, longitude: -22.987157868602548),
                                         CLLocationCoordinate2D(latitude: -43.19952964782715, longitude: -22.986683777289468),
                                         CLLocationCoordinate2D(latitude: -43.20296287536621, longitude: -22.986723284962462),
                                         CLLocationCoordinate2D(latitude: -43.20600986480713, longitude: -22.98664426960494),
                                         CLLocationCoordinate2D(latitude: -43.20927143096924, longitude: -22.986486238751233),
                                         CLLocationCoordinate2D(latitude: -43.211374282836914, longitude: -22.986249192123985),
                                         CLLocationCoordinate2D(latitude: -43.213820457458496, longitude: -22.986130668654358),
                                         CLLocationCoordinate2D(latitude: -43.216094970703125, longitude: -22.986486238751233),
                                         CLLocationCoordinate2D(latitude: -43.218111991882324, longitude: -22.986565254201203)]],
                            date: Date(timeIntervalSinceReferenceDate: 4570))

let prague = Recorded(locations: [[CLLocationCoordinate2D(latitude: 14.420682191848755, longitude: 50.08783638168166),
                                   CLLocationCoordinate2D(latitude: 14.42082166671753, longitude: 50.08758856585596),
                                   CLLocationCoordinate2D(latitude: 14.420961141586304, longitude: 50.08736140022343),
                                   CLLocationCoordinate2D(latitude: 14.421004056930542, longitude: 50.08709981422189),
                                   CLLocationCoordinate2D(latitude: 14.420692920684814, longitude: 50.086838226792665),
                                   CLLocationCoordinate2D(latitude: 14.420242309570312, longitude: 50.086721200375244),
                                   CLLocationCoordinate2D(latitude: 14.419888257980347, longitude: 50.08657663793572),
                                   CLLocationCoordinate2D(latitude: 14.419502019882202, longitude: 50.086721200375244),
                                   CLLocationCoordinate2D(latitude: 14.419201612472534, longitude: 50.08710669808234),
                                   CLLocationCoordinate2D(latitude: 14.418622255325317, longitude: 50.087017207819535),
                                   CLLocationCoordinate2D(latitude: 14.418354034423828, longitude: 50.08694836904213),
                                   CLLocationCoordinate2D(latitude: 14.418021440505981, longitude: 50.08689329794904),
                                   CLLocationCoordinate2D(latitude: 14.417442083358765, longitude: 50.086803807287794),
                                   CLLocationCoordinate2D(latitude: 14.417109489440918, longitude: 50.08670054862488),
                                   CLLocationCoordinate2D(latitude: 14.41705584526062, longitude: 50.0863838873381),
                                   CLLocationCoordinate2D(latitude: 14.416980743408203, longitude: 50.08617048398654),
                                   CLLocationCoordinate2D(latitude: 14.41655158996582, longitude: 50.08610852799683),
                                   CLLocationCoordinate2D(latitude: 14.416025876998901, longitude: 50.086101643993025),
                                   CLLocationCoordinate2D(latitude: 14.415446519851685, longitude: 50.086012151853645),
                                   CLLocationCoordinate2D(latitude: 14.414759874343872, longitude: 50.08599149979777),
                                   CLLocationCoordinate2D(latitude: 14.414105415344238, longitude: 50.08606033994947),
                                   CLLocationCoordinate2D(latitude: 14.413257837295532, longitude: 50.08624620786521),
                                   CLLocationCoordinate2D(latitude: 14.41280722618103, longitude: 50.08628062777049),
                                   CLLocationCoordinate2D(latitude: 14.412528276443481, longitude: 50.086321931624234),
                                   CLLocationCoordinate2D(latitude: 14.412206411361694, longitude: 50.08636323544238),
                                   CLLocationCoordinate2D(latitude: 14.41179871559143, longitude: 50.086418307144534),
                                   CLLocationCoordinate2D(latitude: 14.41129446029663, longitude: 50.0864596108796),
                                   CLLocationCoordinate2D(latitude: 14.410790205001831, longitude: 50.086542218243004),
                                   CLLocationCoordinate2D(latitude: 14.410253763198853, longitude: 50.08661105760374),
                                   CLLocationCoordinate2D(latitude: 14.409524202346802, longitude: 50.086728084290066),
                                   CLLocationCoordinate2D(latitude: 14.409127235412598, longitude: 50.086783155573),
                                   CLLocationCoordinate2D(latitude: 14.408655166625977, longitude: 50.08687953016586),
                                   CLLocationCoordinate2D(latitude: 14.408161640167236, longitude: 50.086934601274784),
                                   CLLocationCoordinate2D(latitude: 14.407893419265747, longitude: 50.08703785943346),
                                   CLLocationCoordinate2D(latitude: 14.407421350479126, longitude: 50.08710669808234)]],
                      date: Date(timeIntervalSinceReferenceDate: 9830))

let bratislava = Recorded(locations: [[CLLocationCoordinate2D(latitude: 17.108298540115356, longitude: 48.14346078730616),
                                       CLLocationCoordinate2D(latitude: 17.1071720123291, longitude: 48.143603967238406),
                                       CLLocationCoordinate2D(latitude: 17.105852365493774, longitude: 48.14404066356508),
                                       CLLocationCoordinate2D(latitude: 17.10517644882202, longitude: 48.14446303844481),
                                       CLLocationCoordinate2D(latitude: 17.104511260986328, longitude: 48.144706439339316),
                                       CLLocationCoordinate2D(latitude: 17.103577852249146, longitude: 48.144498832766395),
                                       CLLocationCoordinate2D(latitude: 17.1021831035614, longitude: 48.1446420098031),
                                       CLLocationCoordinate2D(latitude: 17.101153135299683, longitude: 48.14482098053734),
                                       CLLocationCoordinate2D(latitude: 17.100069522857666, longitude: 48.1447565511449),
                                       CLLocationCoordinate2D(latitude: 17.0992112159729, longitude: 48.14434133756473),
                                       CLLocationCoordinate2D(latitude: 17.09898591041565, longitude: 48.14383305429929),
                                       CLLocationCoordinate2D(latitude: 17.098835706710815, longitude: 48.14338919719027),
                                       CLLocationCoordinate2D(latitude: 17.098653316497803, longitude: 48.14287374540837),
                                       CLLocationCoordinate2D(latitude: 17.09851384162903, longitude: 48.14222226422332),
                                       CLLocationCoordinate2D(latitude: 17.098867893218994, longitude: 48.14173543772033),
                                       CLLocationCoordinate2D(latitude: 17.099887132644653, longitude: 48.14168532296526),
                                       CLLocationCoordinate2D(latitude: 17.10050940513611, longitude: 48.14232249263615)]],
                          date: Date(timeIntervalSinceReferenceDate: 1430))

let wien = Recorded(locations: [[CLLocationCoordinate2D(latitude: 16.358578205108643, longitude: 48.21069704171192),
                                 CLLocationCoordinate2D(latitude: 16.359500885009766, longitude: 48.210561198671094),
                                 CLLocationCoordinate2D(latitude: 16.360273361206055, longitude: 48.21046110356833),
                                 CLLocationCoordinate2D(latitude: 16.360777616500854, longitude: 48.210067870913306),
                                 CLLocationCoordinate2D(latitude: 16.361163854599, longitude: 48.20922419793753),
                                 CLLocationCoordinate2D(latitude: 16.361271142959595, longitude: 48.20880235623749),
                                 CLLocationCoordinate2D(latitude: 16.36109948158264, longitude: 48.20833046140456),
                                 CLLocationCoordinate2D(latitude: 16.361303329467773, longitude: 48.20789431231362),
                                 CLLocationCoordinate2D(latitude: 16.36214017868042, longitude: 48.207400958864895),
                                 CLLocationCoordinate2D(latitude: 16.362934112548828, longitude: 48.20690045050986),
                                 CLLocationCoordinate2D(latitude: 16.36359930038452, longitude: 48.20641423770989),
                                 CLLocationCoordinate2D(latitude: 16.364060640335083, longitude: 48.20596377173197),
                                 CLLocationCoordinate2D(latitude: 16.36310577392578, longitude: 48.205806465219034),
                                 CLLocationCoordinate2D(latitude: 16.362215280532837, longitude: 48.205377445000835),
                                 CLLocationCoordinate2D(latitude: 16.36139988899231, longitude: 48.204834014232304),
                                 CLLocationCoordinate2D(latitude: 16.360541582107544, longitude: 48.20464095191333),
                                 CLLocationCoordinate2D(latitude: 16.359844207763672, longitude: 48.203997405594464),
                                 CLLocationCoordinate2D(latitude: 16.359243392944336, longitude: 48.203618424535)]],
                    date: Date(timeIntervalSinceReferenceDate: 2753))

let barcelona = Recorded(locations: [[CLLocationCoordinate2D(latitude: 2.1604013442993164, longitude: 1.39566054852911),
                                      CLLocationCoordinate2D(latitude: 2.160959243774414, longitude: 1.39522593585012),
                                      CLLocationCoordinate2D(latitude: 2.161409854888916, longitude: 1.394759126402526),
                                      CLLocationCoordinate2D(latitude: 2.1620750427246094, longitude: 1.39426011949272),
                                      CLLocationCoordinate2D(latitude: 2.1627402305603027, longitude: 1.393809400281555),
                                      CLLocationCoordinate2D(latitude: 2.16355562210083, longitude: 1.39319770492482),
                                      CLLocationCoordinate2D(latitude: 2.1642208099365234, longitude: 1.39271478347197),
                                      CLLocationCoordinate2D(latitude: 2.16505765914917, longitude: 1.39199039456595),
                                      CLLocationCoordinate2D(latitude: 2.1658194065093994, longitude: 1.391298193180546),
                                      CLLocationCoordinate2D(latitude: 2.1664953231811523, longitude: 1.390799159702624),
                                      CLLocationCoordinate2D(latitude: 2.167181968688965, longitude: 1.390203534085344),
                                      CLLocationCoordinate2D(latitude: 2.168072462081909, longitude: 1.38960790301097),
                                      CLLocationCoordinate2D(latitude: 2.1690917015075684, longitude: 1.39025182825761),
                                      CLLocationCoordinate2D(latitude: 2.170121669769287, longitude: 1.39107282369714),
                                      CLLocationCoordinate2D(latitude: 2.1709585189819336, longitude: 1.3917489298035),
                                      CLLocationCoordinate2D(latitude: 2.1720528602600098, longitude: 1.39248137015037),
                                      CLLocationCoordinate2D(latitude: 2.1732115745544434, longitude: 1.39335062930365),
                                      CLLocationCoordinate2D(latitude: 2.1742522716522217, longitude: 1.39417158560862),
                                      CLLocationCoordinate2D(latitude: 2.1758615970611572, longitude: 1.39428426507658),
                                      CLLocationCoordinate2D(latitude: 2.176762819290161, longitude: 1.393736962973975),
                                      CLLocationCoordinate2D(latitude: 2.1776962280273438, longitude: 1.39307697489794),
                                      CLLocationCoordinate2D(latitude: 2.1784579753875732, longitude: 1.39251356514109),
                                      CLLocationCoordinate2D(latitude: 2.1793055534362793, longitude: 1.39183746698721),
                                      CLLocationCoordinate2D(latitude: 2.180260419845581, longitude: 1.391314290970904),
                                      CLLocationCoordinate2D(latitude: 2.181183099746704, longitude: 1.390654278297966),
                                      CLLocationCoordinate2D(latitude: 2.181762456893921, longitude: 1.39014719083902),
                                      CLLocationCoordinate2D(latitude: 2.182610034942627, longitude: 1.38955960836037),
                                      CLLocationCoordinate2D(latitude: 2.1832966804504395, longitude: 1.38902031565826),
                                      CLLocationCoordinate2D(latitude: 2.1841442584991455, longitude: 1.38833613191199),
                                      CLLocationCoordinate2D(latitude: 2.1847450733184814, longitude: 1.387925618208236),
                                      CLLocationCoordinate2D(latitude: 2.1852707862854004, longitude: 1.38753925000166),
                                      CLLocationCoordinate2D(latitude: 2.185753583908081, longitude: 1.38715287949905),
                                      CLLocationCoordinate2D(latitude: 2.1863865852355957, longitude: 1.38666991314206)],
                                     [CLLocationCoordinate2D(latitude: 2.169928550720215, longitude: 1.38683895177509),
                                      CLLocationCoordinate2D(latitude: 2.1699178218841553, longitude: 1.38631573553355),
                                      CLLocationCoordinate2D(latitude: 2.1700358390808105, longitude: 1.3857925150817),
                                      CLLocationCoordinate2D(latitude: 2.1704864501953125, longitude: 1.385076098710776),
                                      CLLocationCoordinate2D(latitude: 2.170872688293457, longitude: 1.38443212220268),
                                      CLLocationCoordinate2D(latitude: 2.1713554859161377, longitude: 1.383667391815756),
                                      CLLocationCoordinate2D(latitude: 2.171720266342163, longitude: 1.383047551113755),
                                      CLLocationCoordinate2D(latitude: 2.1721386909484863, longitude: 1.382532354345706),
                                      CLLocationCoordinate2D(latitude: 2.1725356578826904, longitude: 1.38202520354063),
                                      CLLocationCoordinate2D(latitude: 2.1731150150299072, longitude: 1.38134899631476),
                                      CLLocationCoordinate2D(latitude: 2.1737265586853027, longitude: 1.38069693268787),
                                      CLLocationCoordinate2D(latitude: 2.1744132041931152, longitude: 1.37996435957998),
                                      CLLocationCoordinate2D(latitude: 2.1750247478485107, longitude: 1.379280080541925),
                                      CLLocationCoordinate2D(latitude: 2.175421714782715, longitude: 1.37875680347843),
                                      CLLocationCoordinate2D(latitude: 2.175872325897217, longitude: 1.37819326962468),
                                      CLLocationCoordinate2D(latitude: 2.1763336658477783, longitude: 1.37760557911893),
                                      CLLocationCoordinate2D(latitude: 2.176837921142578, longitude: 1.37687297118964),
                                      CLLocationCoordinate2D(latitude: 2.1775245666503906, longitude: 1.376494588038526),
                                      CLLocationCoordinate2D(latitude: 2.1779966354370117, longitude: 1.375753916775494),
                                      CLLocationCoordinate2D(latitude: 2.1782541275024414, longitude: 1.37508569524689),
                                      CLLocationCoordinate2D(latitude: 2.177889347076416, longitude: 1.37461069022704),
                                      CLLocationCoordinate2D(latitude: 2.1773529052734375, longitude: 1.37399076320392),
                                      CLLocationCoordinate2D(latitude: 2.176913022994995, longitude: 1.37342718805608),
                                      CLLocationCoordinate2D(latitude: 2.177610397338867, longitude: 1.373177603216355),
                                      CLLocationCoordinate2D(latitude: 2.1784257888793945, longitude: 1.372823352122225),
                                      CLLocationCoordinate2D(latitude: 2.1792948246002197, longitude: 1.37237248430325),
                                      CLLocationCoordinate2D(latitude: 2.180260419845581, longitude: 1.37189745947061)]],
                         date: Date(timeIntervalSinceReferenceDate: 7632))

let beijing = Recorded(locations: [[CLLocationCoordinate2D(latitude: 116.27411484718323, longitude:40.00127065070959),
                                    CLLocationCoordinate2D(latitude: 116.27428650856018, longitude:40.000563846393405),
                                    CLLocationCoordinate2D(latitude: 116.27474784851074, longitude:40.000185785267426),
                                    CLLocationCoordinate2D(latitude: 116.2741470336914, longitude:39.99970909651632),
                                    CLLocationCoordinate2D(latitude: 116.27437233924866, longitude:39.99958581440115),
                                    CLLocationCoordinate2D(latitude: 116.27395391464233, longitude:39.999257061005856),
                                    CLLocationCoordinate2D(latitude: 116.27357840538025, longitude:39.9986735198311),
                                    CLLocationCoordinate2D(latitude: 116.27382516860962, longitude:39.99815572559906),
                                    CLLocationCoordinate2D(latitude: 116.27415776252747, longitude:39.99768724172024),
                                    CLLocationCoordinate2D(latitude: 116.27494096755981, longitude:39.99778587017236),
                                    CLLocationCoordinate2D(latitude: 116.27575635910034, longitude:39.99822147746522),
                                    CLLocationCoordinate2D(latitude: 116.27696871757507, longitude:39.998377637893576),
                                    CLLocationCoordinate2D(latitude: 116.27785921096802, longitude:39.99847626534852),
                                    CLLocationCoordinate2D(latitude: 116.27883553504944, longitude:39.99845982744926),
                                    CLLocationCoordinate2D(latitude: 116.2791895866394, longitude:39.99744066996676),
                                    CLLocationCoordinate2D(latitude: 116.2798547744751, longitude:39.996799579241035),
                                    CLLocationCoordinate2D(latitude: 116.27936124801636, longitude:39.9966269768635),
                                    CLLocationCoordinate2D(latitude: 116.27998352050781, longitude:39.99654478510184),
                                    CLLocationCoordinate2D(latitude: 116.28031611442566, longitude:39.995969440000245),
                                    CLLocationCoordinate2D(latitude: 116.28039121627808, longitude:39.99527080014614),
                                    CLLocationCoordinate2D(latitude: 116.28045558929443, longitude:39.994506397765065),
                                    CLLocationCoordinate2D(latitude: 116.2804663181305, longitude:39.99361869394048),
                                    CLLocationCoordinate2D(latitude: 116.2803053855896, longitude:39.992673441072775),
                                    CLLocationCoordinate2D(latitude: 116.28011226654053, longitude:39.99177749366983),
                                    CLLocationCoordinate2D(latitude: 116.27968311309814, longitude:39.990873314651076),
                                    CLLocationCoordinate2D(latitude: 116.27882480621338, longitude:39.99045410031764),
                                    CLLocationCoordinate2D(latitude: 116.27752661705017, longitude:39.990717137062866),
                                    CLLocationCoordinate2D(latitude: 116.27660393714905, longitude:39.991136349781954),
                                    CLLocationCoordinate2D(latitude: 116.27626061439514, longitude:39.99185969116893),
                                    CLLocationCoordinate2D(latitude: 116.27535939216614, longitude:39.99136650469056)]],
                       date: Date(timeIntervalSinceReferenceDate: 16432))

let hongKong = Recorded(locations: [[CLLocationCoordinate2D(latitude: 114.16903138160706, longitude: 22.320869765946114),
                                     CLLocationCoordinate2D(latitude: 114.17022228240967, longitude: 22.321018639964308),
                                     CLLocationCoordinate2D(latitude: 114.17041540145874, longitude: 22.320115468479834),
                                     CLLocationCoordinate2D(latitude: 114.17000770568848, longitude: 22.319430642249316),
                                     CLLocationCoordinate2D(latitude: 114.16958928108215, longitude: 22.31857708601147),
                                     CLLocationCoordinate2D(latitude: 114.16984677314758, longitude: 22.317395993771314),
                                     CLLocationCoordinate2D(latitude: 114.17019009590149, longitude: 22.315996535407482),
                                     CLLocationCoordinate2D(latitude: 114.17028665542603, longitude: 22.315123107473845),
                                     CLLocationCoordinate2D(latitude: 114.17049050331116, longitude: 22.314180196183955),
                                     CLLocationCoordinate2D(latitude: 114.17073726654053, longitude: 22.3129593647372),
                                     CLLocationCoordinate2D(latitude: 114.17091965675354, longitude: 22.311877480793143),
                                     CLLocationCoordinate2D(latitude: 114.17113423347473, longitude: 22.310954398873587),
                                     CLLocationCoordinate2D(latitude: 114.1710913181305, longitude: 22.309822870776),
                                     CLLocationCoordinate2D(latitude: 114.1712737083435, longitude: 22.308334004045925),
                                     CLLocationCoordinate2D(latitude: 114.17128443717957, longitude: 22.30744067638816),
                                     CLLocationCoordinate2D(latitude: 114.17145609855652, longitude: 22.30645800936429),
                                     CLLocationCoordinate2D(latitude: 114.17150974273682, longitude: 22.305505113525754),
                                     CLLocationCoordinate2D(latitude: 114.17167067527771, longitude: 22.30448272846913),
                                     CLLocationCoordinate2D(latitude: 114.17168140411377, longitude: 22.303321369374498),
                                     CLLocationCoordinate2D(latitude: 114.17172431945801, longitude: 22.301802654450015),
                                     CLLocationCoordinate2D(latitude: 114.1719388961792, longitude: 22.300075468390673),
                                     CLLocationCoordinate2D(latitude: 114.17206764221191, longitude: 22.298407820208883),
                                     CLLocationCoordinate2D(latitude: 114.17223930358887, longitude: 22.29670044549571),
                                     CLLocationCoordinate2D(latitude: 114.17241096496582, longitude: 22.294933489231475),
                                     CLLocationCoordinate2D(latitude: 114.17404174804688, longitude: 22.29507246412925),
                                     CLLocationCoordinate2D(latitude: 114.1753077507019, longitude: 22.295012903475698),
                                     CLLocationCoordinate2D(latitude: 114.17595148086548, longitude: 22.294337880961216),
                                     CLLocationCoordinate2D(latitude: 114.17457818984985, longitude: 22.293801831347448),
                                     CLLocationCoordinate2D(latitude: 114.17356967926025, longitude: 22.293504025117947),
                                     CLLocationCoordinate2D(latitude: 114.17326927185059, longitude: 22.294556270955066),
                                     CLLocationCoordinate2D(latitude: 114.17146682739258, longitude: 22.294496710081507),
                                     CLLocationCoordinate2D(latitude: 114.16987895965576, longitude: 22.294258466333368),
                                     CLLocationCoordinate2D(latitude: 114.16897773742676, longitude: 22.293623147685903)],
                                    [CLLocationCoordinate2D(latitude: 114.1523265838623, longitude: 22.28421215199964),
                                     CLLocationCoordinate2D(latitude: 114.15314197540283, longitude: 22.28345765655827),
                                     CLLocationCoordinate2D(latitude: 114.153892993927, longitude: 22.28262373580718),
                                     CLLocationCoordinate2D(latitude: 114.15496587753296, longitude: 22.28246489319545),
                                     CLLocationCoordinate2D(latitude: 114.15560960769653, longitude: 22.281511833735625),
                                     CLLocationCoordinate2D(latitude: 114.15623188018799, longitude: 22.28075732372299),
                                     CLLocationCoordinate2D(latitude: 114.15647864341736, longitude: 22.281908942633333),
                                     CLLocationCoordinate2D(latitude: 114.1554594039917, longitude: 22.283090334935583),
                                     CLLocationCoordinate2D(latitude: 114.15420413017273, longitude: 22.284182369362036),
                                     CLLocationCoordinate2D(latitude: 114.15345311164856, longitude: 22.284857440923126),
                                     CLLocationCoordinate2D(latitude: 114.15409684181213, longitude: 22.285810477577723),
                                     CLLocationCoordinate2D(latitude: 114.15522336959839, longitude: 22.285879969579653),
                                     CLLocationCoordinate2D(latitude: 114.15624260902405, longitude: 22.284926933398786)],
                                    [CLLocationCoordinate2D(latitude: 114.16950345039368, longitude: 22.277838522970633),
                                     CLLocationCoordinate2D(latitude: 114.17133808135986, longitude: 22.277669746914345),
                                     CLLocationCoordinate2D(latitude: 114.17296886444092, longitude: 22.27760025083199),
                                     CLLocationCoordinate2D(latitude: 114.17453527450562, longitude: 22.277798810975703),
                                     CLLocationCoordinate2D(latitude: 114.17564034461975, longitude: 22.278414345629724),
                                     CLLocationCoordinate2D(latitude: 114.17706727981567, longitude: 22.278513625158908),
                                     CLLocationCoordinate2D(latitude: 114.17884826660156, longitude: 22.27905966130964),
                                     CLLocationCoordinate2D(latitude: 114.18037176132202, longitude: 22.279605695328364),
                                     CLLocationCoordinate2D(latitude: 114.18201327323914, longitude: 22.280260933336546),
                                     CLLocationCoordinate2D(latitude: 114.18365478515625, longitude: 22.280608406792076),
                                     CLLocationCoordinate2D(latitude: 114.18517827987671, longitude: 22.280380067189995),
                                     CLLocationCoordinate2D(latitude: 114.18665885925293, longitude: 22.280866529371536),
                                     CLLocationCoordinate2D(latitude: 114.18833255767822, longitude: 22.281174290285865),
                                     CLLocationCoordinate2D(latitude: 114.18952345848083, longitude: 22.282038002782265),
                                     CLLocationCoordinate2D(latitude: 114.19026374816895, longitude: 22.283090334935583),
                                     CLLocationCoordinate2D(latitude: 114.19052124023438, longitude: 22.28381504964329),
                                     CLLocationCoordinate2D(latitude: 114.19169068336487, longitude: 22.28487729591971),
                                     CLLocationCoordinate2D(latitude: 114.19164776802063, longitude: 22.285860114725487),
                                     CLLocationCoordinate2D(latitude: 114.19166922569275, longitude: 22.287160601716867),
                                     CLLocationCoordinate2D(latitude: 114.19277429580688, longitude: 22.28839158589097),
                                     CLLocationCoordinate2D(latitude: 114.19361114501953, longitude: 22.289384307167353),
                                     CLLocationCoordinate2D(latitude: 114.1948127746582, longitude: 22.29065498011298),
                                     CLLocationCoordinate2D(latitude: 114.19663667678833, longitude: 22.291419363741987)]],
                        date: Date(timeIntervalSinceReferenceDate: 21593))

