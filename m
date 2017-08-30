From: horms@verge.net.au (Simon Horman)
Date: Wed, 30 Aug 2017 08:44:03 +0200
Subject: [PATCH] arm64: dts: draak: Add serial console pins
In-Reply-To: <1503912370-20180-1-git-send-email-geert+renesas@glider.be>
References: <1503912370-20180-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20170830064402.GB10398@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 28, 2017 at 11:26:10AM +0200, Geert Uytterhoeven wrote:
> Add pin control for SCIF2.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> To be applied after v4.14-rc1, when commit 794a6711764658a1 ("pinctrl:
> sh-pfc: Initial R8A77995 PFC support") has hit mainline.
> 
> Else the serial console will fail, reporting (on earlycon):
> 
>     sh-sci e6e88000.serial: could not find pctldev for node /soc/pin-controller at e6060000/scif2, deferring probe

Thanks, please ping me once that has happened.
In the meantime I have marked this patch as deferred.
