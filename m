From: Joerg.Roedel@amd.com (Joerg Roedel)
Date: Mon, 5 Mar 2012 15:39:58 +0100
Subject: [PATCH] ARM: OMAP: fix iommu, not mailbox
In-Reply-To: <1330855271-28820-1-git-send-email-ohad@wizery.com>
References: <1330855271-28820-1-git-send-email-ohad@wizery.com>
Message-ID: <20120305143957.GK10684@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 04, 2012 at 12:01:11PM +0200, Ohad Ben-Cohen wrote:
> For some weird (freudian?) reason, commit 435792d "ARM: OMAP: make
> iommu subsys_initcall to fix builtin omap3isp" unintentionally changed
> the mailbox's initcall instead of the iommu's.
> 
> Fix that.

Applied, thanks.

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
