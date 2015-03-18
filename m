From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 18 Mar 2015 11:30:04 +0100
Subject: [PATCH] ARM: dts: sun9i: Enable ARM architected timer on A80
In-Reply-To: <1426665628-32014-1-git-send-email-wens@csie.org>
References: <1426665628-32014-1-git-send-email-wens@csie.org>
Message-ID: <20150318103004.GQ4638@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 18, 2015 at 04:00:28PM +0800, Chen-Yu Tsai wrote:
> The A80 SoC has the architected timer, but the existing firmware from
> Allwinner does not set CNTFRQ at all.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Merged, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150318/36f01c9a/attachment.sig>
