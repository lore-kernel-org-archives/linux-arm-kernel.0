From: olof@lixom.net (Olof Johansson)
Date: Fri, 17 Jul 2015 10:35:57 -0700
Subject: [PATCH 3/3] arm64: dts: add Rockchip rk3368 core dtsi and board
 dts for the r88 board
In-Reply-To: <1689279.HMMcieeDok@diego>
References: <2820374.NgluYWXZkW@diego>
 <1689279.HMMcieeDok@diego>
Message-ID: <20150717173557.GD28326@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 17, 2015 at 12:34:53AM +0200, Heiko St?bner wrote:
> In terms of peripherals the rk3368 is quite similar to the rk3288, which
> makes it possible to have a lot basic components working in the first go.
> More to follow once I tracked down all the tiny differences that still
> exist in some parts.
> 
> With these dts files, the R88 board is able to boot from an attached
> usb device and most likely from its emmc too, if the emmc uses a standard
> partition table instead of Rockchip's own one - the emmc itself is
> detected correctly.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
> as mentioned in the cover letter, needed dependency (stable branch)
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-rk3368
> 

Merged in the branch and applied the patch. Thanks.


-Olof
