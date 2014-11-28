From: jroedel@suse.de (jroedel at suse.de)
Date: Fri, 28 Nov 2014 14:03:36 +0100
Subject: [RFC PATCH v4 0/8] Introduce automatic DMA configuration for
 IOMMU masters
In-Reply-To: <20141126174707.GO14866@arm.com>
References: <1415991397-9618-1-git-send-email-will.deacon@arm.com>
 <546C7D36.7030400@samsung.com> <20141119114150.GD15985@arm.com>
 <54743139.2020804@samsung.com> <20141126174707.GO14866@arm.com>
Message-ID: <20141128130336.GF3156@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 26, 2014 at 05:47:07PM +0000, Will Deacon wrote:
> Joerg, would you expect this to go via your tree or via something broader
> like arm-soc, with your Ack on the IOMMU bits (patches 1, 3 and 4) instead?

Hmm, I don't like the idea of storing private data in iommu_ops. But
given that this is already an improvement we can build on later, here is
my

	Acked-by: Joerg Roedel <jroedel@suse.de>

To further improve this we should probably introduce a seperate
iommu-descriptor data-structure later which then describes a single
hardware iommu device.


	Joerg
