From: hari.kanigeri@gmail.com (Hari Kanigeri)
Date: Thu, 1 Jul 2010 17:51:01 -0500
Subject: [RFC 3/3] mm: iommu: The Virtual Contiguous Memory Manager
In-Reply-To: <4C2D0FF1.6010206@codeaurora.org>
References: <1277877350-2147-1-git-send-email-zpfeffer@codeaurora.org>
	<1277877350-2147-3-git-send-email-zpfeffer@codeaurora.org>
	<20100701101746.3810cc3b.randy.dunlap@oracle.com>
	<20100701180241.GA3594@basil.fritz.box>
	<1278012503.7738.17.camel@c-dwalke-linux.qualcomm.com>
	<20100701193850.GB3594@basil.fritz.box>
	<4C2D0FF1.6010206@codeaurora.org>
Message-ID: <AANLkTilQnopqrS-KrR3btOIkH68fIEdipWFF6fkO6fNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The VCMM takes the long view. Its designed for a future in which the
> number of IOMMUs will go up and the ways in which these IOMMUs are
> composed will vary from system to system, and may vary at
> runtime. Already, there are ~20 different IOMMU map implementations in
> the kernel. Had the Linux kernel had the VCMM, many of those
> implementations could have leveraged the mapping and topology management
> of a VCMM, while focusing on a few key hardware specific functions (map
> this physical address, program the page table base register).
>

-- Sounds good.
Did you think of a way to handle the cases where one of the Device
that is using the mapped address crashed ?
How is the physical address unbacked in this case ?

Hari
