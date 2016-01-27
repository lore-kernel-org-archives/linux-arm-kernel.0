From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 27 Jan 2016 18:33:11 +0100
Subject: [PATCH RFC 08/11] clk: sunxi: factors: Drop round_rate from clk
 ops
In-Reply-To: <1453727747-23307-9-git-send-email-wens@csie.org>
References: <1453727747-23307-1-git-send-email-wens@csie.org>
 <1453727747-23307-9-git-send-email-wens@csie.org>
Message-ID: <20160127173311.GM4317@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2016 at 09:15:44PM +0800, Chen-Yu Tsai wrote:
> The common clock framework requires either determine_rate or round_rate
> to be implemented. We use determine_rate so we can pass the parent index
> to the get_factors callback. This cannot be done easily with round_rate,
> so just drop it.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160127/d56df6d1/attachment.sig>
