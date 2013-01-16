From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 16 Jan 2013 15:06:00 -0700
Subject: [PATCH 1/7] dt: describe base reset signal binding
In-Reply-To: <1358352787-15441-2-git-send-email-p.zabel@pengutronix.de>
References: <1358352787-15441-1-git-send-email-p.zabel@pengutronix.de>
 <1358352787-15441-2-git-send-email-p.zabel@pengutronix.de>
Message-ID: <50F72448.8070807@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/16/2013 09:13 AM, Philipp Zabel wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> This binding is intended to represent the hardware reset signals present
> internally in most IC (SoC, FPGA, ...) designs.
> 
> Such a binding would allow the creation of a "reset subsystem", which
> could replace APIs such as the following Tegra-specific API:
> 
> void tegra_periph_reset_deassert(struct clk *c);
> void tegra_periph_reset_assert(struct clk *c);
> 
> (Note that at present, Tegra couples reset assertion with the clock for
> the affected peripheral module. However, reset and clocking are two
> separate, yet admittedly related, concepts).
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

You probably want to update the patch description; it was somewhat
appropriate when I sent the patch as an RFC to see what people thought
about the idea, but now you're actually providing the whole thing a more
specific description would be better.

Your S-o-b line should be present in all patches you send; add it after
mine. See Documentation/SubmittingPatches section "Sign your work" item
(c) (or perhaps (b) if you modified it).
