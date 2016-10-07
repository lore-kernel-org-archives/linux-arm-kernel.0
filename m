From: horms@verge.net.au (Simon Horman)
Date: Fri, 7 Oct 2016 12:33:52 +0900
Subject: [PATCH] ARM: dts: r8a7794: Fix W=1 dtc warnings
In-Reply-To: <1475587908-22151-1-git-send-email-geert+renesas@glider.be>
References: <1475587908-22151-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20161007033352.GP13721@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 04, 2016 at 03:31:48PM +0200, Geert Uytterhoeven wrote:
> Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,dvc/dvc at 0 has a unit name, but no reg property

...

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/arm/boot/dts/r8a7794.dtsi | 58 +++++++++++++++++++++---------------------
>  1 file changed, 29 insertions(+), 29 deletions(-)

Thanks, I have queued this up.
