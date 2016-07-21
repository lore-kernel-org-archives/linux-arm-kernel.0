From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 21 Jul 2016 10:58:38 +0200
Subject: [PATCH 3/3] mmc: sunxi: Add support to the Allwinner A83T
In-Reply-To: <0ddc5f7d9a42515f901c95b8c0c1f5a5e4d575e9.1469082481.git.moinejf@free.fr>
References: <cover.1469082481.git.moinejf@free.fr>
 <0ddc5f7d9a42515f901c95b8c0c1f5a5e4d575e9.1469082481.git.moinejf@free.fr>
Message-ID: <20160721085838.GH5993@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Maxime

On Wed, Jul 20, 2016 at 08:28:47PM +0200, Jean-Francois Moine wrote:
> The rate of the PLL-PERIPH clock is usually set to 1.2GHz in the A83T.

Uh? The datasheet says to set it to 600MHz.

> This patch sets the phase delays of the output and sample clocks
> accordingly.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---
> Note: The impacted phase delays are only for 50MHz.
> The phase delays are not used in 50MHz 8 bits DDR (new timing mode).

Actually, they seem to be, in the new timing mode register.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160721/50da17d5/attachment.sig>
