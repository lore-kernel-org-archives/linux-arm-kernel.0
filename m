From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu, 26 Jul 2018 23:26:19 +0800
Subject: [PATCH] ARM: dts: sun8i: r40/v40: rewrite BPi M2 Berry DTS to
 rebase on M2 Ultra
In-Reply-To: <20180726152427.cjji4ymwfjifja4q@flea>
References: <20180724163655.61365-1-icenowy@aosc.io>
 <20180726124119.dwne2sncws2p3sdi@flea>
 <BA51039A-02DD-42C2-A7A9-E1B866074CA6@aosc.io>
 <20180726152427.cjji4ymwfjifja4q@flea>
Message-ID: <7A9506F1-7052-4801-B735-296370EBBA7C@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2018?7?26? GMT+08:00 ??11:24:27, Maxime Ripard <maxime.ripard@bootlin.com> ??:
>On Thu, Jul 26, 2018 at 08:47:34PM +0800, Icenowy Zheng wrote:
>> 
>> 
>> ? 2018?7?26? GMT+08:00 ??8:41:19, Maxime Ripard
><maxime.ripard@bootlin.com> ??:
>> >On Wed, Jul 25, 2018 at 12:36:55AM +0800, Icenowy Zheng wrote:
>> >> Banana Pi designs the BPi M2 Berry board to be software compatible
>> >with
>> >> BPi M2 Ultra,
>> >
>> >Do you have a reference for this?
>> 
>> See [1], it says "BPI-M2U and BPI-M2 Berry share the same image".
>> 
>> [1] http://www.banana-pi.org/download.html
>
>Debian supports different SoC from different vendor using the same
>image, so it's not really a good argument to share the device tree. I
>mean, you can even boot an H3 to a shell using an A33 device tree.

Please note that the vendor image is fully functional BSP
image, neither a function limited one nor one without
HW configuration.

>
>Maxime
