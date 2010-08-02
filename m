From: Joerg.Roedel@amd.com (Roedel, Joerg)
Date: Mon, 2 Aug 2010 10:10:13 +0200
Subject: [PATCH 1/2] arm: msm: Add System MMU support.
In-Reply-To: <1280736182.1902.55.camel@pasglop>
References: <ea4bbdecc271f7fa5749d09645f38c0d.squirrel@www.codeaurora.org>
	<bad58db98c165a61860827d4e720acf8.squirrel@www.codeaurora.org>
	<20100729123512Y.fujita.tomonori@lab.ntt.co.jp>
	<201007291026.55928.arnd@arndb.de>
	<1280546124.1902.30.camel@pasglop> <20100802074812.GM24084@amd.com>
	<1280736182.1902.55.camel@pasglop>
Message-ID: <20100802081012.GA29744@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 02, 2010 at 04:03:02AM -0400, Benjamin Herrenschmidt wrote:
> On Mon, 2010-08-02 at 09:48 +0200, Roedel, Joerg wrote:
> > > Hrm, indeed I just noticed that. Pretty gross... it should definitly
> > be
> > > renamed, is will caused endless confusion with unrelated iommu.h and
> > > iommu_* interfaces which represent something different.
> > 
> > The first direction to go should be trying to unify all the different
> > iommu* interfaces into the iommu-api. The generic api will definitly
> > need to be extended for that, but since it is an in-kernel interface
> > thats no problem. 
> 
> Well, I suppose I'm the de-facto candidate to take care of the powerpc
> side then :-)
> 
> I don't have the bandwidth right now, but I'll try to have a look when
> time permits.

Great :-)

-- 
Joerg Roedel - AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
