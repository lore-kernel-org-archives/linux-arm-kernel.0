From: Joerg.Roedel@amd.com (Roedel, Joerg)
Date: Wed, 8 Jun 2011 15:35:55 +0200
Subject: [PATCH 0/4] drivers/iommu/ relocations
In-Reply-To: <BANLkTin5JYt4=gru181N_BuvnHB7kUTUeQ@mail.gmail.com>
References: <1307522062-19273-1-git-send-email-ohad@wizery.com>
	<20110608130522.GC29089@parisc-linux.org>
	<BANLkTin5JYt4=gru181N_BuvnHB7kUTUeQ@mail.gmail.com>
Message-ID: <20110608133555.GC21591@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2011 at 09:11:16AM -0400, Ohad Ben-Cohen wrote:
> On Wed, Jun 8, 2011 at 4:05 PM, Matthew Wilcox <matthew@wil.cx> wrote:
> > You've missed at least parisc, ia64, alpha, sparc, powerpc and sh which
> > have IOMMUs.
> 
> None of these seem to call register_iommu.
> 
> > Not that they necessarily all need to be moved across in
> > one patchset, but saying "all iommu drivers" is clearly false.
> 
> I've moved only the existing IOMMU API users.

And I think that is good for now. The iommu-api needs to be extended to
cover all kinds of iommus (like the iommus available on other
architectures). It is definitly the plan to do that and have a common
dma_ops implementation for all of them. But lets start small by now and
move forward step by step :-)

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
