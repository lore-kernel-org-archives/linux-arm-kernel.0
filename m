From: robh@kernel.org (Rob Herring)
Date: Thu, 21 Apr 2016 07:47:15 -0500
Subject: dtc warnings
In-Reply-To: <CAL_Jsq+=OjY8y_8x7OSm-MWYKbrHN5cbv4TLwULxhNq+gfiMtw@mail.gmail.com>
References: <CAL_Jsq+=OjY8y_8x7OSm-MWYKbrHN5cbv4TLwULxhNq+gfiMtw@mail.gmail.com>
Message-ID: <CAL_Jsq+fWBkNK6gVAuyp8L3gUoztaYJGaCy47rrqke2AKKhEcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 31, 2016 at 8:40 PM, Rob Herring <robh@kernel.org> wrote:
> You may have noticed that linux-next had gotten noisy with dtc
> warnings lately. I dropped the change for a bit, but added it back
> today except now it is disabled unless building with "W=1".
>
> There's ~25K (2500 unique) warnings generated from the ARM dts files.
> Here's the ranking of warnings by dtb. OMAP is the clear winner (based
> on the similar counts, probably lots of duplicates). Please help
> remind contributors to test with W=1 and start to fix these.

Good progress here. Next is now 11054 total, 1516 unique. Here's the
top ones now:

165 : arch/arm/boot/dts/atlas7-evb.dtb
91 : arch/arm/boot/dts/at91-sama5d4ek.dtb
90 : arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dtb
88 : arch/arm/boot/dts/at91-sama5d4_xplained.dtb
87 : arch/arm/boot/dts/at91-vinco.dtb
82 : arch/arm/boot/dts/at91-sama5d2_xplained.dtb
79 : arch/arm/boot/dts/keystone-k2hk-evm.dtb
74 : arch/arm/boot/dts/ste-nomadik-s8815.dtb
74 : arch/arm/boot/dts/ste-nomadik-nhk15.dtb
73 : arch/arm/boot/dts/at91-sama5d3_xplained.dtb
72 : arch/arm/boot/dts/sama5d36ek.dtb
70 : arch/arm/boot/dts/sama5d35ek.dtb
70 : arch/arm/boot/dts/sama5d34ek.dtb
69 : arch/arm/boot/dts/sama5d31ek.dtb
68 : arch/arm/boot/dts/at91-kizbox2.dtb
67 : arch/arm/boot/dts/sama5d33ek.dtb
65 : arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dtb
65 : arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dtb
64 : arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dtb
62 : arch/arm/boot/dts/atlas6-evb.dtb
61 : arch/arm/boot/dts/prima2-evb.dtb
59 : arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dtb
59 : arch/arm/boot/dts/sun7i-a20-pcduino3.dtb
59 : arch/arm/boot/dts/keystone-k2l-evm.dtb
58 : arch/arm/boot/dts/sun7i-a20-cubietruck.dtb
57 : arch/arm/boot/dts/sun7i-a20-orangepi-mini.dtb
57 : arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dtb
57 : arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dtb
57 : arch/arm/boot/dts/sun7i-a20-i12-tvbox.dtb
56 : arch/arm/boot/dts/sun7i-a20-orangepi.dtb
56 : arch/arm/boot/dts/sun7i-a20-lamobo-r1.dtb
56 : arch/arm/boot/dts/sun7i-a20-bananapro.dtb
56 : arch/arm/boot/dts/sun7i-a20-bananapi.dtb
55 : arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dtb
55 : arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dtb
55 : arch/arm/boot/dts/sun7i-a20-mk808c.dtb
55 : arch/arm/boot/dts/sun7i-a20-hummingbird.dtb
55 : arch/arm/boot/dts/sun7i-a20-cubieboard2.dtb
54 : arch/arm/boot/dts/sun7i-a20-m3.dtb
54 : arch/arm/boot/dts/sun7i-a20-itead-ibox.dtb
53 : arch/arm/boot/dts/sun7i-a20-icnova-swac.dtb
51 : arch/arm/boot/dts/at91sam9x35ek.dtb
50 : arch/arm/boot/dts/at91sam9x25ek.dtb
49 : arch/arm/boot/dts/at91sam9g35ek.dtb
48 : arch/arm/boot/dts/at91sam9g15ek.dtb
48 : arch/arm/boot/dts/at91-ariag25.dtb
47 : arch/arm/boot/dts/at91sam9g25ek.dtb
47 : arch/arm/boot/dts/at91-cosino_mega2560.dtb
46 : arch/arm/boot/dts/pm9g45.dtb

Rob
