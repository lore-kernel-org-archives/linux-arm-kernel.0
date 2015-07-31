From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 31 Jul 2015 20:01:37 +0200
Subject: [PATCH v2 2/2] ARM: multi_v7_defconfig: Enable Allwinner P2WI,
 PWM, DMA_SUN6I, cryptodev
In-Reply-To: <1438354602-6361-3-git-send-email-wens@csie.org>
References: <1438354602-6361-1-git-send-email-wens@csie.org>
 <1438354602-6361-3-git-send-email-wens@csie.org>
Message-ID: <20150731180137.GQ2564@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 31, 2015 at 10:56:42PM +0800, Chen-Yu Tsai wrote:
> Enable drivers for Allwinner P2WI, PWM, cryptodev (Security System) and
> sun6i DMA engine. Also enable EXTCON as PHY_SUN4I_USB depends on it.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150731/d87ffc61/attachment.sig>
