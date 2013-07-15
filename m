From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 15 Jul 2013 15:42:35 +0200
Subject: [PATCH] clk: sunxi: Fix checking return value of
 clk_register_[composite|factors]
In-Reply-To: <1373616915.24328.1.camel@phoenix>
References: <1373616915.24328.1.camel@phoenix>
Message-ID: <20130715134235.GF2962@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Axel,


On Fri, Jul 12, 2013 at 04:15:15PM +0800, Axel Lin wrote:
> clk_register_composite() and clk_register_factors() return ERR_PTR on error.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks for this patch!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130715/24106ae7/attachment.sig>
