From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 27 Sep 2014 09:06:01 +0200
Subject: [PATCH v3 1/2] clk: sunxi: Add sun8i MBUS clock support
In-Reply-To: <1410861842-2743-2-git-send-email-wens@csie.org>
References: <1410861842-2743-1-git-send-email-wens@csie.org>
 <1410861842-2743-2-git-send-email-wens@csie.org>
Message-ID: <20140927070601.GX15315@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 16, 2014 at 06:04:01PM +0800, Chen-Yu Tsai wrote:
> The MBUS clock on sun8i is slightly different from the old mod0 clocks.
> The divider is 3 bits wider, while also needing a divider table for the
> higher 4 values, which all set the same divider.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140927/e227f7e0/attachment.sig>
