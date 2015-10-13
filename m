From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 13 Oct 2015 20:46:30 +0200
Subject: [PATCH v2 3/5] ARM: dts: sun6i: hummingbird: Use axp22x.dtsi for
 AXP221 regulators
In-Reply-To: <1444488540-11263-4-git-send-email-wens@csie.org>
References: <1444488540-11263-1-git-send-email-wens@csie.org>
 <1444488540-11263-4-git-send-email-wens@csie.org>
Message-ID: <20151013184630.GR2278@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 10, 2015 at 10:48:58PM +0800, Chen-Yu Tsai wrote:
> Now that we have axp22x.dtsi describing common axp22x hardware, use
> it and reference the nodes instead of declaring the whole tree.
> 
> Also drop the "always-on" from the vdd-gpu regulator, since we don't
> support the GPU anyway.
> 
> And add a regulator reference for cpu0.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151013/0b6b0920/attachment.sig>
