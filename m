From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 10 Feb 2014 20:48:43 +0100
Subject: [PATCH v4 1/8] clk: sunxi: Add Allwinner A20/A31 GMAC clock unit
In-Reply-To: <1392028554-32545-2-git-send-email-wens@csie.org>
References: <1392028554-32545-1-git-send-email-wens@csie.org>
 <1392028554-32545-2-git-send-email-wens@csie.org>
Message-ID: <20140210194843.GZ3192@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 06:35:47PM +0800, Chen-Yu Tsai wrote:
> The Allwinner A20/A31 clock module controls the transmit clock source
> and interface type of the GMAC ethernet controller. Model this as
> a single clock for GMAC drivers to use.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140210/de47ace9/attachment.sig>
