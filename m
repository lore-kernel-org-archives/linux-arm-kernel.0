From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 10 Mar 2015 22:27:12 +0100
Subject: [PATCH v5 01/12] ARM: dts: sun6i: add p2wi controller node to dtsi
In-Reply-To: <1425988764-23618-2-git-send-email-wens@csie.org>
References: <1425988764-23618-1-git-send-email-wens@csie.org>
 <1425988764-23618-2-git-send-email-wens@csie.org>
Message-ID: <20150310212712.GC5085@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 10, 2015 at 07:59:12PM +0800, Chen-Yu Tsai wrote:
> From: Boris BREZILLON <boris.brezillon@free-electrons.com>
> 
> The p2wi controller has only one possible pinmux setting. Use it by
> default in the dtsi, instead of having to set it in each board's dts.
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> [wens at csie.org: reformat commit title; rename p2wi pins and use as default]
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150310/c527473a/attachment.sig>
