From: Joerg.Roedel@amd.com (Roedel, Joerg)
Date: Tue, 23 Aug 2011 16:26:35 +0200
Subject: [PATCH 0/7] omap: iommu migration, relocation and cleanups
In-Reply-To: <1313622608-30397-1-git-send-email-ohad@wizery.com>
References: <1313622608-30397-1-git-send-email-ohad@wizery.com>
Message-ID: <20110823142635.GQ2079@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 17, 2011 at 07:10:01PM -0400, Ohad Ben-Cohen wrote:
> 1. Migrate OMAP's iommu driver to the generic IOMMU API, and move it
> to the dedicated iommu folder.
> 
> 2. Fix omap3isp appropriately so it doesn't break.
> 
> 3. Adapt OMAP's iovmm appropriately as well, because omap3isp still relies
> on it. The plan is eventually to remove iovmm and replace it with the
> upcoming IOMMU-based generic DMA-API. Move iovmm to the iommu folder too;
> it belongs there more than it belongs in the OMAP folders.
> 
> 4. Start cleaning up OMAP's iommu components towards the end goal, where
>     1) omap-iommu no longer exports public API (and instead provides its
>        entire functionality via the generic IOMMU API).
>     2) omap-iovmm is removed.

Besides the locking issue these patches look good to me. Please repost
when this is solved and I will put it in my tree then.

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
