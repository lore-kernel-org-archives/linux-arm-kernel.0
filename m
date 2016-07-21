From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 21 Jul 2016 10:49:37 +0200
Subject: [PATCH 1/3] mmc: sunxi: Check the value returned by clk_round_rate
In-Reply-To: <c2231f3df66cf77e4fb9051f7b0c27ea69b8e63d.1469082481.git.moinejf@free.fr>
References: <cover.1469082481.git.moinejf@free.fr>
 <c2231f3df66cf77e4fb9051f7b0c27ea69b8e63d.1469082481.git.moinejf@free.fr>
Message-ID: <20160721084937.GF5993@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 20, 2016 at 08:01:47PM +0200, Jean-Francois Moine wrote:
> clk_round_rate() may return an error. Check it.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160721/4f538229/attachment.sig>
