From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 13 Oct 2015 20:46:45 +0200
Subject: [PATCH v2 4/5] ARM: dts: sun6i: hummingbird: Enable AXP221
 DC5LDO regulator as "vdd-cpus"
In-Reply-To: <1444488540-11263-5-git-send-email-wens@csie.org>
References: <1444488540-11263-1-git-send-email-wens@csie.org>
 <1444488540-11263-5-git-send-email-wens@csie.org>
Message-ID: <20151013184645.GS2278@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 10, 2015 at 10:48:59PM +0800, Chen-Yu Tsai wrote:
> The DC5LDO regulator supplies VDD-CPUS, which is for the embedded
> controller in the A31 SoC.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151013/d9f6b85d/attachment-0001.sig>
