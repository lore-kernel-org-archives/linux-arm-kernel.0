From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Sun, 28 Aug 2016 18:26:59 +0800
Subject: [PATCH v2] ARM: dts: sun8i: enable UART1 for iNet D978 Rev2 board
In-Reply-To: <20160828080334.e7kul4n75i3hqk5t@vip.cybercity.dk>
References: <20160828005521.58221-1-icenowy@aosc.xyz>
 <20160828080334.e7kul4n75i3hqk5t@vip.cybercity.dk>
Message-ID: <32051472380019@web17j.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



28.08.2016, 16:17, "Rask Ingemann Lambertsen" <ccc94453@vip.cybercity.dk>:
> On Sun, Aug 28, 2016 at 08:55:21AM +0800, Icenowy Zheng wrote:
>> ?+ uart1_pins_cts_rts_a: uart1_cts_rts at 0 {
>> ?+ allwinner,pins = "PG8", "PG9";
>> ?+ allwinner,function = "uart1";
>> ?+ allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>> ?+ allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>> ?+ };
>
> Node names should not contain underscores. Use hyphens instead.

Sorry. It's my fault.
In the v1 patch the name is hyphens... but I rewrote the part in v2.

> https://www.mail-archive.com/linux-kernel%40vger.kernel.org/msg1122967.html
> https://www.mail-archive.com/linux-kernel%40vger.kernel.org/msg1145633.html
>
> --
> Rask Ingemann Lambertsen
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
