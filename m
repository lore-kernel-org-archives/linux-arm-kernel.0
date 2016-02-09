From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 9 Feb 2016 09:14:41 +0100
Subject: [PATCH 5/6] ARM: multi_v7_defconfig: Enable A10 audio codec
 driver as module
In-Reply-To: <1454774029-10469-6-git-send-email-wens@csie.org>
References: <1454774029-10469-1-git-send-email-wens@csie.org>
 <1454774029-10469-6-git-send-email-wens@csie.org>
Message-ID: <20160209081441.GO31506@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 06, 2016 at 11:53:48PM +0800, Chen-Yu Tsai wrote:
> The A10 audio codec driver supports the on-chip audio codec found on
> Allwinner A10, A10s, A13, A20 SoCs.
> 
> Build it as a module, since it is not critical.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160209/838b56a1/attachment.sig>
