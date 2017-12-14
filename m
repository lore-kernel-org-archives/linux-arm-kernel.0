From: robh@kernel.org (Rob Herring)
Date: Thu, 14 Dec 2017 12:21:06 -0600
Subject: DT dtc warnings
Message-ID: <CAL_JsqJKCzjx3zNigu_0T=Ku=_P2SQEjTx=uVbvr_QxJQR7kYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Below is a current list of ARM boards with more than 40 dtc warnings
when building with W=1. There's a treewide patch in flight to fix some
unit-address warnings[1], so those aren't included here. The list is
grouped by maintainer. AT91, Exynos, and Allwinner continue to be at
the top of the list and have been for some time (though having
multiple boards for an SoC can cause lots of duplicated warnings).

Please help fix these. More checks are being added[2].

Rob

[1] https://patchwork.kernel.org/patch/10112725/
[2] https://www.spinics.net/lists/devicetree-compiler/msg01620.html


77 - arch/arm/boot/dts/prima2-evb.dts

50 - arch/arm/boot/dts/exynos5250-arndale.dts
50 - arch/arm/boot/dts/exynos5250-smdk5250.dts
50 - arch/arm/boot/dts/exynos5250-snow.dts
50 - arch/arm/boot/dts/exynos5250-snow-rev5.dts
50 - arch/arm/boot/dts/exynos5250-spring.dts
71 - arch/arm/boot/dts/exynos5420-arndale-octa.dts
71 - arch/arm/boot/dts/exynos5420-peach-pit.dts
71 - arch/arm/boot/dts/exynos5420-smdk5420.dts
71 - arch/arm/boot/dts/exynos5422-odroidhc1.dts
71 - arch/arm/boot/dts/exynos5422-odroidxu3.dts
71 - arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts
71 - arch/arm/boot/dts/exynos5422-odroidxu4.dts
71 - arch/arm/boot/dts/exynos5800-peach-pi.dts

42 - arch/arm/boot/dts/sun5i-gr8-evb.dts
44 - arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
49 - arch/arm/boot/dts/sun7i-a20-icnova-swac.dts
50 - arch/arm/boot/dts/sun7i-a20-itead-ibox.dts
50 - arch/arm/boot/dts/sun7i-a20-m3.dts
51 - arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
51 - arch/arm/boot/dts/sun7i-a20-mk808c.dts
51 - arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts
53 - arch/arm/boot/dts/sun7i-a20-bananapi.dts
53 - arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
53 - arch/arm/boot/dts/sun7i-a20-hummingbird.dts
53 - arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
53 - arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
53 - arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts
53 - arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts
54 - arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
54 - arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts
55 - arch/arm/boot/dts/sun7i-a20-bananapro.dts
55 - arch/arm/boot/dts/sun7i-a20-cubietruck.dts
55 - arch/arm/boot/dts/sun7i-a20-orangepi.dts
55 - arch/arm/boot/dts/sun7i-a20-pcduino3.dts
55 - arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
56 - arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts
61 - arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
61 - arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
61 - arch/arm/boot/dts/sun7i-a20-olinuxino-micro-emmc.dts

46 - arch/arm/boot/dts/at91sam9rlek.dts
48 - arch/arm/boot/dts/at91sam9261ek.dts
50 - arch/arm/boot/dts/at91-kizbox.dts
50 - arch/arm/boot/dts/at91-qil_a9260.dts
51 - arch/arm/boot/dts/at91rm9200ek.dts
52 - arch/arm/boot/dts/at91sam9g20ek.dts
52 - arch/arm/boot/dts/at91-sam9_l9260.dts
53 - arch/arm/boot/dts/at91-foxg20.dts
53 - arch/arm/boot/dts/at91sam9260ek.dts
53 - arch/arm/boot/dts/at91sam9g20ek_2mmc.dts
54 - arch/arm/boot/dts/at91sam9263ek.dts
56 - arch/arm/boot/dts/at91sam9n12ek.dts
61 - arch/arm/boot/dts/at91-cosino_mega2560.dts
61 - arch/arm/boot/dts/at91sam9m10g45ek.dts
62 - arch/arm/boot/dts/at91-ariettag25.dts
63 - arch/arm/boot/dts/at91-ariag25.dts
64 - arch/arm/boot/dts/at91-kizboxmini.dts
64 - arch/arm/boot/dts/at91sam9g15ek.dts
65 - arch/arm/boot/dts/at91sam9g25ek.dts
66 - arch/arm/boot/dts/at91sam9g35ek.dts
69 - arch/arm/boot/dts/at91sam9x25ek.dts
70 - arch/arm/boot/dts/at91sam9x35ek.dts
74 - arch/arm/boot/dts/sama5d33ek.dts
75 - arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
75 - arch/arm/boot/dts/at91-sama5d2_xplained.dts
76 - arch/arm/boot/dts/at91-kizbox2.dts
77 - arch/arm/boot/dts/sama5d31ek.dts
80 - arch/arm/boot/dts/sama5d34ek.dts
81 - arch/arm/boot/dts/sama5d35ek.dts
84 - arch/arm/boot/dts/at91-sama5d3_xplained.dts
84 - arch/arm/boot/dts/sama5d36ek_cmp.dts
84 - arch/arm/boot/dts/sama5d36ek.dts
93 - arch/arm/boot/dts/at91-sama5d4ek.dts
93 - arch/arm/boot/dts/at91-sama5d4_xplained.dts
93 - arch/arm/boot/dts/at91-vinco.dts
94 - arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dts
77 - arch/arm/boot/dts/at91-tse850-3.dts

40 - arch/arm/boot/dts/stih410-b2260.dts
43 - arch/arm/boot/dts/stih410-b2120.dts

52 - arch/arm/boot/dts/keystone-k2e-evm.dts
73 - arch/arm/boot/dts/keystone-k2l-evm.dts
97 - arch/arm/boot/dts/keystone-k2hk-evm.dts

Boards with no maintainer:
192 - arch/arm/boot/dts/atlas7-evb.dts
50 - arch/arm/boot/dts/aks-cdu.dts
50 - arch/arm/boot/dts/animeo_ip.dts
50 - arch/arm/boot/dts/ethernut5.dts
50 - arch/arm/boot/dts/evk-pro3.dts
50 - arch/arm/boot/dts/tny_a9260.dts
50 - arch/arm/boot/dts/tny_a9g20.dts
50 - arch/arm/boot/dts/usb_a9260.dts
50 - arch/arm/boot/dts/usb_a9g20.dts
50 - arch/arm/boot/dts/usb_a9g20_lpw.dts
51 - arch/arm/boot/dts/mpa1600.dts
54 - arch/arm/boot/dts/tny_a9263.dts
54 - arch/arm/boot/dts/usb_a9263.dts
60 - arch/arm/boot/dts/pm9g45.dts
75 - arch/arm/boot/dts/ste-nomadik-nhk15.dts
75 - arch/arm/boot/dts/ste-nomadik-s8815.dts
77 - arch/arm/boot/dts/atlas6-evb.dts
