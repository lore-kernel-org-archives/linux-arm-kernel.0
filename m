From: joerg.roedel@amd.com (Joerg Roedel)
Date: Wed, 7 Dec 2011 19:12:56 +0100
Subject: [PATCH] iommu/msm: Fix compile error in mach-msm/devices-iommu.c
In-Reply-To: <20111207170024.GA23621@huya.qualcomm.com>
References: <20111206102527.GI25178@amd.com>
 <20111207170024.GA23621@huya.qualcomm.com>
Message-ID: <20111207181256.GA2181@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 07, 2011 at 09:00:24AM -0800, David Brown wrote:
> On Tue, Dec 06, 2011 at 11:25:27AM +0100, Joerg Roedel wrote:
> 
> > I just added a patch to my iommu/fixes branch to fix a compile error
> > with IOMMU enabled. If there is another fix for this already somewhere
> > please let me know the commit-id so that I can add it to my out-of-tree
> > branch. If there is no other fix yet I will push this upstream soon with
> > the next round of iommu-fixes.
> 
> You can go ahead and push this fix through your tree.  I'll enable the
> iommu in my defconfigs so that I start catching things like this as
> well.

Great, Thanks.

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
