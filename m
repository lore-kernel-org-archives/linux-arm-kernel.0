From: balbi@ti.com (Felipe Balbi)
Date: Mon, 13 Jan 2014 10:24:37 -0600
Subject: [PATCH 0/2] ARM: DRA7XX/AM43XX build fixes
In-Reply-To: <1389347850-22435-1-git-send-email-t-kristo@ti.com>
References: <1389347850-22435-1-git-send-email-t-kristo@ti.com>
Message-ID: <20140113162412.GF26950@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 10, 2014 at 11:57:28AM +0200, Tero Kristo wrote:
> The move of clock code from mach-omap2 to drivers/clk/ti introduces
> a couple of new build errors with AM43XX/DRA7XX only builds. The
> following patches address these issues by modifying the Kconfig + Makefile
> under mach-omap2.
> 
> Also, it seems DRA7XX only build is not possible at the moment, added
> patch #2 to fix this.

looks like we still need some extra patches since OMAP2-only builds
still fail :-(

Also omap1_defconfig fails miserably :-(

hoping this can still get fixed in time for 3.14 :-s

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140113/2e974c57/attachment.sig>
