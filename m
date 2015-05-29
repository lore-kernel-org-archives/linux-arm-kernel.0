From: joro@8bytes.org (Joerg Roedel)
Date: Fri, 29 May 2015 11:03:22 +0200
Subject: [PATCH 0/4] arm64: IOMMU-backed DMA mapping
In-Reply-To: <cover.1432735420.git.robin.murphy@arm.com>
References: <cover.1432735420.git.robin.murphy@arm.com>
Message-ID: <20150529090322.GF13130@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

Thanks for your work. We are really moving forward to a common DMA-API
implementation for all iommu drivers.

On Wed, May 27, 2015 at 03:09:14PM +0100, Robin Murphy wrote:
> In the meantime, Laurent's proposal for probe deferral[2] offers hope
> that the bus notifier dance may only need to be short-lived, and I'm
> hoping to spend some more time on DT-based IOMMU group handling for
> platform devices, which should hopefully tie in with default domains
> to make the add_device callback mostly redundant.

Yes, this would be great. I think it makes a lot of sense to make use of
the default domain feature. Can you have a look at how well this
integrates with my current patches for default domains and provide some
feedback?

Thanks,

	Joerg
