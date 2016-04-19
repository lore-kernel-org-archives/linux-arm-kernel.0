From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 19 Apr 2016 11:16:05 +0200
Subject: [PATCH v3 05/19] dt-bindings: clk: sun5i: add DRAM gates
 compatible
In-Reply-To: <20160415222911.GR14441@codeaurora.org>
References: <1458751122-23976-1-git-send-email-maxime.ripard@free-electrons.com>
 <1458751122-23976-6-git-send-email-maxime.ripard@free-electrons.com>
 <20160415222911.GR14441@codeaurora.org>
Message-ID: <20160419091605.GW4005@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 15, 2016 at 03:29:11PM -0700, Stephen Boyd wrote:
> On 03/23, Maxime Ripard wrote:
> > The Allwinner SoCs have a gate controller to gate the access to the DRAM
> > clock to the some devices that need to access the DRAM directly (mostly
> > display / image related IPs).
> > 
> > Use a simple gates driver to support the one found in the A13 / R8 SoCs.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > Acked-by: Chen-Yu Tsai <wens@csie.org>
> > Acked-by: Rob Herring <robh@kernel.org>
> > ---
> 
> Acked-by: Stephen Boyd <sboyd@codeaurora.org>

Applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160419/b344a51d/attachment.sig>
