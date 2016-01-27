From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 27 Jan 2016 18:47:42 +0100
Subject: [PATCH RFC 10/11] clk: sunxi: rewrite sun6i-ar100 using factors
 clk
In-Reply-To: <1453727747-23307-11-git-send-email-wens@csie.org>
References: <1453727747-23307-1-git-send-email-wens@csie.org>
 <1453727747-23307-11-git-send-email-wens@csie.org>
Message-ID: <20160127174742.GO4317@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2016 at 09:15:46PM +0800, Chen-Yu Tsai wrote:
> sun6i's AR100 clock is a classic factors clk case:
> 
> AR100 = ((parent mux) >> p) / (m + 1)
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160127/ab856279/attachment.sig>
