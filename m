From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 6 Oct 2009 11:59:44 -0400
Subject: [PATCH 0/3] ep93xx/micro9: Update Contec Micro9 board support
In-Reply-To: <1254823677-14036-1-git-send-email-hubert.feurstein@contec.at>
References: <1254823677-14036-1-git-send-email-hubert.feurstein@contec.at>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901DB7881@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, October 06, 2009 3:08 AM, Hubert Feurstein wrote:
> This patch series updates the Contec Micro9 maintainer and the platform
> code. Also support for a new Micro9 variant, the Micro9-Slim, is added.
> The code is rebased against the latest linus-tree. These patches require
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=5744/1
> to be applied first (because of EP93XX_SDCE3_PHYS_BASE_ASYNC).
> 
> Hubert Feurstein (3):
>   ep93xx/micro9: Update maintainer
>   ep93xx/micro9: Update platform code
>   ep93xx/micro9: Add Micro9-Slim
> 
>  MAINTAINERS                                     |    5 +
>  arch/arm/mach-ep93xx/Kconfig                    |   22 +++--
>  arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |   11 ++
>  arch/arm/mach-ep93xx/micro9.c                   |  132 +++++++++++++----------
>  4 files changed, 108 insertions(+), 62 deletions(-)

Hubert,

You have my Acked-by for this patch series.  Please submit to Russell King's
patch system.  Please add them in order so that they merge cleanly.

Regards,
Hartley
