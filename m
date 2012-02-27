From: Joerg.Roedel@amd.com (Joerg Roedel)
Date: Mon, 27 Feb 2012 14:23:01 +0100
Subject: [PATCH] ARM: OMAP: make iommu subsys_initcall to fix builtin
 omap3isp
In-Reply-To: <1330251254-14693-1-git-send-email-ohad@wizery.com>
References: <1330251254-14693-1-git-send-email-ohad@wizery.com>
Message-ID: <20120227132301.GC7905@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 26, 2012 at 12:14:14PM +0200, Ohad Ben-Cohen wrote:
> omap3isp depends on omap's iommu and will fail to probe if
> initialized before it (which always happen if they are builtin).
> 
> Make omap's iommu subsys_initcall as an interim solution until
> the probe deferral mechanism is merged.
> 
> Reported-by: James <angweiyang@gmail.com>
> Debugged-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> Cc: stable <stable@vger.kernel.org>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Hiroshi Doyu <hdoyu@nvidia.com>
> Cc: Joerg Roedel <Joerg.Roedel@amd.com>

Applied, thanks.

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
