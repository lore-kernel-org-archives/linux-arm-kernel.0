From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 9 Feb 2016 09:02:27 +0100
Subject: [PATCH 4/6] ARM: sunxi_defconfig: Enable INPUT_EVDEV so
 axp20x-pek can be used
In-Reply-To: <1454774029-10469-5-git-send-email-wens@csie.org>
References: <1454774029-10469-1-git-send-email-wens@csie.org>
 <1454774029-10469-5-git-send-email-wens@csie.org>
Message-ID: <20160209080227.GM31506@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 06, 2016 at 11:53:47PM +0800, Chen-Yu Tsai wrote:
> sunxi_defconfig already enables INPUT_AXP20X_PEK, but the device is not
> exposed to userspace. Enable INPUT_EVDEV so it is.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160209/fd736a3d/attachment.sig>
