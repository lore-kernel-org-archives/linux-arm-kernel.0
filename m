From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 18 Mar 2015 11:21:32 +0100
Subject: [PATCH 1/3] ARM: dts: sun8i: Enable ARM architected timer on A23
In-Reply-To: <1426649042-30547-2-git-send-email-wens@csie.org>
References: <1426649042-30547-1-git-send-email-wens@csie.org>
 <1426649042-30547-2-git-send-email-wens@csie.org>
Message-ID: <20150318102132.GO4638@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 18, 2015 at 11:24:00AM +0800, Chen-Yu Tsai wrote:
> The A23 SoC has the architected timer, but the existing firmware from
> Allwinner does not set CNTFRQ at all.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150318/592adb36/attachment.sig>
