From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 4 Jan 2018 13:53:42 +0100
Subject: [PATCH 5/5] ARM: dts: imx28-cfa10049: Move i2cmux out of bus node
In-Reply-To: <1514383478-32544-5-git-send-email-festevam@gmail.com>
References: <1514383478-32544-1-git-send-email-festevam@gmail.com>
 <1514383478-32544-5-git-send-email-festevam@gmail.com>
Message-ID: <20180104125342.w2iwhs2cbj6ymdue@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 27, 2017 at 12:04:38PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Move i2cmux node from soc node to root node.
> 
> i2cmux node does not have any register properties and thus shouldn't be
> placed on the bus.
> 
> This fixes the following build warnings with W=1:
> 
> arch/arm/boot/dts/imx28-cfa10049.dtb: Warning (simple_bus_reg): Node /apb at 80000000/apbx at 80040000/i2cmux missing or empty reg/ranges property
> 
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180104/6213d373/attachment-0001.sig>
