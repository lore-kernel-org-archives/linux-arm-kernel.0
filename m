From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 11 Nov 2014 15:55:19 +0100
Subject: [PATCH resend 0/4] clk: sunxi: Unify sun4i apb1 clock
In-Reply-To: <1415245232-20585-1-git-send-email-wens@csie.org>
References: <1415245232-20585-1-git-send-email-wens@csie.org>
Message-ID: <20141111145519.GI14919@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 06, 2014 at 11:40:28AM +0800, Chen-Yu Tsai wrote:
> (resent with linux-arm-kernel CCed)
> 
> Hi everyone,
> 
> This series unifies the apb1 clock driver for sun4i, which was
> previously split into apb1-mux and apb1. This also fixes the
> apb2 clock on sun6i/sun8i, which we now have documents for.
> 
> The first 2 patches were done by Emilio.
> 
> Patch 1 unifies the apb1-mux and apb1 clock drivers using a
> factors clock.
> 
> Patch 2 unifies said clocks in the dtsi.
> 
> Patch 3 switches the compatibles for apb2 clock on sun6i/sun8i to
> the unified sun4i apb1 clock.
> 
> Patch 4 gets rid of the incorrect and now unused sun6i apb2 clock
> driver.

Merged all the patches, thanks!

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141111/51eabbf6/attachment.sig>
