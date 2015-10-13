From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 13 Oct 2015 20:46:01 +0200
Subject: [PATCH v2 1/5] ARM: dts: sun6i: hummingbird: Fix VDD-CPU and
 VDD-GPU regulator names
In-Reply-To: <1444488540-11263-2-git-send-email-wens@csie.org>
References: <1444488540-11263-1-git-send-email-wens@csie.org>
 <1444488540-11263-2-git-send-email-wens@csie.org>
Message-ID: <20151013184601.GQ2278@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 10, 2015 at 10:48:56PM +0800, Chen-Yu Tsai wrote:
> The VDD-CPU and VDD-GPU regulators were incorrectly swapped.
> 
> Fixes: bab03561224ba ("ARM: dts: sun6i: hummingbird: Add AXP221 regulator
>        nodes")
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151013/9334c4a3/attachment.sig>
