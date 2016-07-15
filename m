From: joro@8bytes.org (Joerg Roedel)
Date: Fri, 15 Jul 2016 18:16:51 +0200
Subject: iommu/rockchip: Fix bugs and enable on ARM64
In-Reply-To: <575f6cd7-6e03-e701-78ed-ea2fe9f7573c@suse.com>
References: <1466734413-7453-1-git-send-email-zhengsq@rock-chips.com>
 <20160627125751.GN11432@8bytes.org>
 <577EFB86.1060502@rock-chips.com>
 <575f6cd7-6e03-e701-78ed-ea2fe9f7573c@suse.com>
Message-ID: <20160715161651.GS12639@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 15, 2016 at 05:32:02PM +0200, Matthias Brugger wrote:
> >The drm rockchip patches are dependent on iommu/rockchip patches, can
> >you also apply these patches together? So that can avoid compile problem.
> >
> 
> While at it. I don't see patch 8 (iommu/Kconfig) in linux-next.
> I suppose you forgot to pick that one.

I picked it up first, but it causes compile errors, so I removed it for
now.


	Joerg
