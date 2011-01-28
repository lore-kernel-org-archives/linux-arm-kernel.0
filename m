From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 28 Jan 2011 18:07:37 +0530
Subject: [PATCH 0/6] omap4: prcm: Few dpll,
	clockdomain and powerdomain updates
In-Reply-To: <1296212688-21951-1-git-send-email-santosh.shilimkar@ti.com>
References: <1296212688-21951-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <029aba12236fbe44e366cd12222ec138@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Santosh Shilimkar [mailto:santosh.shilimkar at ti.com]
> Sent: Friday, January 28, 2011 4:35 PM
> To: linux-omap at vger.kernel.org
> Cc: khilman at ti.com; paul at pwsan.com; b-cousson at ti.com; rnayak at ti.com;
> linux-arm-kernel at lists.infradead.org; Santosh Shilimkar
> Subject: [PATCH 0/6] omap4: prcm: Few dpll, clockdomain and
> powerdomain updates
>
> The series mainly contains dpll initialisation, CPUx clock
> domain offset fix, addiing INACTIVE power domain state and
> fixing logic flag for IVAHD and ABE power domains.
>
> The series is boot tested on OMAP4430 SDP.
>
> The following changes since commit
> 1bae4ce27c9c90344f23c65ea6966c50ffeae2f5:
>   Linus Torvalds (1):
>         Linux 2.6.38-rc2
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-
> 2.6.git omap4_prcm_misc
>
With corrected git URL:
git://dev.omapzoom.org/pub/scm/santosh/kernel-omap4-base.git
omap4_prcm_misc

Regards,
Santosh
