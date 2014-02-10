From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 10 Feb 2014 20:47:35 +0100
Subject: [PATCH v4 0/8] Add Allwinner A20 GMAC ethernet support
In-Reply-To: <1392028554-32545-1-git-send-email-wens@csie.org>
References: <1392028554-32545-1-git-send-email-wens@csie.org>
Message-ID: <20140210194735.GY3192@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chen-Yu,

On Mon, Feb 10, 2014 at 06:35:46PM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> This is the v4 of the remaining Allwinner A20 GMAC glue layer patches.
> The stmmac driver changes have been merged through net-next. The
> remaining bits are clock and DT patches. The patches should be applied
> over my clock renaming patches.
> 
> The Allwinner A20 SoC integrates an early version of dwmac
> IP from Synopsys. On top of that is a hardware glue layer.
> This layer needs to be configured before the dwmac can be
> used.
> 
> Part of the glue layer is a clock mux, which controls the
> source and direction of the TX clock used by GMAC.

Just merged patches 2-8.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140210/907e36b8/attachment.sig>
