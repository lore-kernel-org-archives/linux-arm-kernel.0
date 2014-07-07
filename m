From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 7 Jul 2014 11:00:20 +0200
Subject: [PATCH v3 7/9] ARM: sunxi: select MFD_SUN6I_PRCM when sun8i arch
 support is enabled
In-Reply-To: <1404399349-20237-8-git-send-email-wens@csie.org>
References: <1404399349-20237-1-git-send-email-wens@csie.org>
 <1404399349-20237-8-git-send-email-wens@csie.org>
Message-ID: <20140707090020.GH16262@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 03, 2014 at 10:55:47PM +0800, Chen-Yu Tsai wrote:
> Select the MFD_SUN6I_PRCM option when sun8i arch is enabled in order to
> get the PRCM (Power/Reset/Clock Management) related drivers compiled.
> 
> Also select ARCH_HAS_RESET_CONTROLLER and RESET_CONTROLLER to make sure
> the reset controller drivers are compiled.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140707/0eb1982a/attachment.sig>
