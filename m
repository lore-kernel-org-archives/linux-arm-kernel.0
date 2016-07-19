From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Tue, 19 Jul 2016 16:59:58 +0800
Subject: [PATCH 0/4] mmc: sunxi: Make sample clocks optional
In-Reply-To: <1468665964-27142-1-git-send-email-hdegoede@redhat.com>
References: <1468665964-27142-1-git-send-email-hdegoede@redhat.com>
Message-ID: <262161468918798@web25j.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



16.07.2016, 18:50, "Hans de Goede" <hdegoede@redhat.com>:
> Hi All,
>
> It turns out that sun4i / sun5i do not have sample clocks at all,
> so make them optional. Also remove the DDR capability when there
> are no sample clocks because DDR modes do not work reliably without
> them (observed on an UTOO P66 tablet with eMMC).
>
> Ulf, can you please merge the first 2 patches, patches 3-4 should
> be merged through Maxime's sunxi/dts tree, but not before the first
> 2 have hit linux-next.
>
> Regards,
>
> Hans
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Interesting...

A64 have also no external sample/output clock... (The sample/output clock is integrated into MMC IP core now)
