From: joerg.roedel@amd.com (Joerg Roedel)
Date: Tue, 8 Nov 2011 18:43:08 +0100
Subject: [PATCH] arm: cpuidle34xx.c: Fix compile error
In-Reply-To: <87hb2eqzwv.fsf@ti.com>
References: <1320768665-9759-1-git-send-email-joerg.roedel@amd.com>
 <87hb2eqzwv.fsf@ti.com>
Message-ID: <20111108174308.GG5182@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 08, 2011 at 09:36:48AM -0800, Kevin Hilman wrote:
> Joerg Roedel <joerg.roedel@amd.com> writes:
> 
> > Add missing module.h include to provide THIS_MODULE.
> >
> > Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
> 
> FYI...
> 
> Tony has already queued fix for this in his fixes branch.
> 
>      http://marc.info/?l=linux-arm-kernel&m=132071036621713&w=2

Great. I stumbled over it while compile-testing the iommu-tree for omap.

Thanks,

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
