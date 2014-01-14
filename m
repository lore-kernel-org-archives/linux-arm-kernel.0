From: horms@verge.net.au (Simon Horman)
Date: Tue, 14 Jan 2014 09:46:38 +0900
Subject: [PATCH V2 0/3] SoC and board integration for QSPI on
 r8a7791/koelsch
In-Reply-To: <1389524433-2823-1-git-send-email-geert@linux-m68k.org>
References: <1389524433-2823-1-git-send-email-geert@linux-m68k.org>
Message-ID: <20140114004638.GE18217@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 12, 2014 at 12:00:29PM +0100, Geert Uytterhoeven wrote:
> This series adds support for the Spansion s25fl512s SPI FLASH on the
> r8a7791-based Koelsch board. It is based on
> renesas-devel-v3.13-rc7-20140109v2, with Valentine's i2c pinctrl and
> Laurent's SCIF DT work applied on top.
> [Simon: I don't know in which order you will merge these. If you want me
>  to rebase my patches, just ask! Thanks!]

I see that Laruent has taken patch 1/4.

Is it possible for me to merge patches 2-4/4 independently of that patch?
That is, can I apply them and still produce a kernel that boots. If so,
that is my preferred option. If not I will talk to Laurent about a branch
to base things on.

Also, I would like to get an Ack from Magnus.

> 
> This applies to non-multiplatform Koelsch only.  Multi-platform Koelsch
> support will be added in a separate series.
> 
>     [1/4] pinctrl: sh-pfc: r8a7791: Add QSPI pin groups
>     [2/4] ARM: shmobile: r8a7791: add QSPI clocks
>     [3/4] ARM: shmobile: koelsch: Add QSPI support
>     [4/4] ARM: shmobile: koelsch: Enable RSPI and MTD_M25P80 in
> 
> Changes in V2:
>   - Split QSPI pins in 2 sets of 3 pin groups
>   - Add "[PATCH V2 4/4] ARM: shmobile: koelsch: Enable RSPI and MTD_M25P80
>     in defconfig"
> 
> Thanks!
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
> 
