From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 9 Apr 2015 09:33:46 +0200
Subject: [PATCH] ARM: Remove deprecated symbol from defconfig files
In-Reply-To: <1428353842-3488-1-git-send-email-public_timo.s@silentcreek.de>
References: <1428353842-3488-1-git-send-email-public_timo.s@silentcreek.de>
Message-ID: <20150409073346.GK26727@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 06, 2015 at 10:57:22PM +0200, public_timo.s at silentcreek.de wrote:
> From: Timo Sigurdsson <public_timo.s@silentcreek.de>
> 
> Commit b2b3a8b934e6 ("power/reset: Remove sun6i reboot driver") removed
> the sun6i reboot driver. But sunxi_defconfig and multi_v7_defconfig
> still contain the symbol CONFIG_POWER_RESET_SUN6I that was deprecated
> by that commit, so remove it.
> 
> Signed-off-by: Timo Sigurdsson <public_timo.s@silentcreek.de>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150409/b38796a6/attachment-0001.sig>
