From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 20 Nov 2015 12:48:30 +0100
Subject: [PATCH v2 3/3] ARM: sunxi: Clean up sunxi_defconfig
In-Reply-To: <1447983979-12751-3-git-send-email-public_timo.s@silentcreek.de>
References: <1447724578-4786-1-git-send-email-public_timo.s@silentcreek.de>
 <1447983979-12751-1-git-send-email-public_timo.s@silentcreek.de>
 <1447983979-12751-3-git-send-email-public_timo.s@silentcreek.de>
Message-ID: <20151120114830.GC32142@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2015 at 02:46:19AM +0100, Timo Sigurdsson wrote:
> Clean up sunxi_defconfig by generating a fresh file via
>   make sunxi_defconfig
>   make savedefconfig
> 
> While this moves around a few lines and removes unnecessary symbols,
> it doesn't introduce any functional changes. The resulting .config is
> identical before and after this patch.
> 
> Signed-off-by: Timo Sigurdsson <public_timo.s@silentcreek.de>

Applied all 3 patches, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151120/c0e4010d/attachment-0001.sig>
