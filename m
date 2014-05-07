From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 7 May 2014 12:34:32 +0530
Subject: [PATCH RESEND] dma: mmp_pdma: add support for residue reporting
In-Reply-To: <53641C2E.8020101@zonque.org>
References: <534576C3.2020409@zonque.org> <20140416064534.GL32284@intel.com>
 <534E3F3D.5080003@zonque.org> <20140416082326.GM32284@intel.com>
 <534E4172.8030401@zonque.org> <20140416090923.GR32284@intel.com>
 <534E9AC1.1040706@zonque.org> <20140416160109.GU32284@intel.com>
 <534EB276.4000408@zonque.org> <53641C2E.8020101@zonque.org>
Message-ID: <20140507070432.GK28638@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 03, 2014 at 12:29:02AM +0200, Daniel Mack wrote:
> Hi Vinod,
> 
> On 04/16/2014 06:40 PM, Daniel Mack wrote:
 
> Just in case you missed that over the other mmp_pdma patches: as pointed
> out above, dma_set_residue() already does the NULL pointer check you
> asked for, so there's nothing to fix up here. IIRC, we were eventually
> on the same page regarding all the other details, right?
Yes and now i have applied the patch.

Thanks
-- 
~Vinod
