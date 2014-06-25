From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 25 Jun 2014 22:15:51 +0200
Subject: [PATCH v3 3/6] clk: sunxi: Support factor clocks with N factor
 starting not from 0
In-Reply-To: <1403603980-31101-4-git-send-email-wens@csie.org>
References: <1403603980-31101-1-git-send-email-wens@csie.org>
 <1403603980-31101-4-git-send-email-wens@csie.org>
Message-ID: <20140625201551.GI19569@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 24, 2014 at 05:59:37PM +0800, Chen-Yu Tsai wrote:
> The PLLs on newer Allwinner SoC's, such as the A31 and A23, have a
> N multiplier factor that starts from 1, not 0.
> 
> This patch adds an option to the factor clk driver's config data
> structures to specify the base value of N.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140625/8c803a00/attachment.sig>
