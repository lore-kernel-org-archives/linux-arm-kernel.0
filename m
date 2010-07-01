From: hari.kanigeri@gmail.com (Hari Kanigeri)
Date: Thu, 1 Jul 2010 17:15:27 -0500
Subject: [RFC 3/3] mm: iommu: The Virtual Contiguous Memory Manager
In-Reply-To: <1278013320.7738.19.camel@c-dwalke-linux.qualcomm.com>
References: <1277877350-2147-1-git-send-email-zpfeffer@codeaurora.org>
	<1277877350-2147-3-git-send-email-zpfeffer@codeaurora.org>
	<20100701101746.3810cc3b.randy.dunlap@oracle.com>
	<20100701180241.GA3594@basil.fritz.box>
	<1278012503.7738.17.camel@c-dwalke-linux.qualcomm.com>
	<20100701193850.GB3594@basil.fritz.box>
	<1278013320.7738.19.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <AANLkTinABCSdN6hnXVOvVZ12f1QBMR_UAi62qW8GmlkL@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
> He demonstrated the usage of his code in one of the emails he sent out
> initially. Did you go over that, and what (or how many) step would you
> use with the current code to do the same thing?

-- So is this patch set adding layers and abstractions to help the User ?

If the idea is to share some memory across multiple devices, I guess
you can achieve the same by calling the map function provided by iommu
module and sharing the mapped address to the 10's or 100's of devices
to access the buffers. You would only need a dedicated virtual pool
per IOMMU device to manage its virtual memory allocations.

Hari
