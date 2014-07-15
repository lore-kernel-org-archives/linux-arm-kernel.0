From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 15 Jul 2014 08:53:08 +0200
Subject: [PATCH v4 1/6] clk: sunxi: sun6i-apb0-gates: use bitmaps for
 valid gate indicies
In-Reply-To: <1404892479-12222-2-git-send-email-wens@csie.org>
References: <1404892479-12222-1-git-send-email-wens@csie.org>
 <1404892479-12222-2-git-send-email-wens@csie.org>
Message-ID: <20140715065308.GB3745@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jul 09, 2014 at 03:54:34PM +0800, Chen-Yu Tsai wrote:
> sun6i-apb0-gates uses the "clock-indices" DT property to indicate
> valid gate bits or holes in between. However, the rest of sunxi
> clock drivers use bitmaps for this purpose.
> 
> This patch modifies sun6i-apb0-gates to use bitmaps as well, to be
> consistent with the sunxi platform. Also add the missing call to
> clk_register_clkdev, so system clock lookups will work.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, and fixed the typo in the title.

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
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140715/0134a27a/attachment.sig>
