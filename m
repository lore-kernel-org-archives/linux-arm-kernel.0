From: joro@8bytes.org (Joerg Roedel)
Date: Sat, 10 Jul 2010 16:56:39 +0200
Subject: [RFC 3/3] mm: iommu: The Virtual Contiguous Memory Manager
In-Reply-To: <4C2D965F.5000206@codeaurora.org>
References: <1277877350-2147-1-git-send-email-zpfeffer@codeaurora.org>
	<1277877350-2147-3-git-send-email-zpfeffer@codeaurora.org>
	<20100701101746.3810cc3b.randy.dunlap@oracle.com>
	<20100701180241.GA3594@basil.fritz.box>
	<1278021944.7738.43.camel@c-dwalke-linux.qualcomm.com>
	<4C2D965F.5000206@codeaurora.org>
Message-ID: <20100710145639.GC10080@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 02, 2010 at 12:33:51AM -0700, Zach Pfeffer wrote:
> Daniel Walker wrote:

> > So if we include this code which "map implementations" could you
> > collapse into this implementations ? Generally , what currently existing
> > code can VCMM help to eliminate?
> 
> In theory, it can eliminate all code the interoperates between IOMMU,
> CPU and non-IOMMU based devices and all the mapping code, alignment,
> mapping attribute and special block size support that's been
> implemented.

Thats a very abstract statement. Can you point to particular code files
and give a rough sketch how it could be improved using VCMM?

	Joerg
