From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 20 Sep 2014 12:33:56 +0200
Subject: [PATCH v2 2/3] dmaengine: sun6i: Add support for Allwinner A23
 (sun8i) variant
In-Reply-To: <1411010680-4481-3-git-send-email-wens@csie.org>
References: <1411010680-4481-1-git-send-email-wens@csie.org>
 <1411010680-4481-3-git-send-email-wens@csie.org>
Message-ID: <20140920103356.GR2166@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 18, 2014 at 11:24:39AM +0800, Chen-Yu Tsai wrote:
> The A23 SoC has the same dma engine as the A31 (sun6i), with a
> reduced amount of endpoints and physical channels. Add the proper
> config data and compatible string to support it.
> 
> A slight difference in sun8i is an undocumented register needs
> to be toggled for dma to function.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140920/9a28efe9/attachment.sig>
