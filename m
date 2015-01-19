From: joro@8bytes.org (joro at 8bytes.org)
Date: Mon, 19 Jan 2015 14:09:41 +0100
Subject: [PATCH v2 0/5] Generic IOMMU page table framework
In-Reply-To: <20150116140130.GQ7091@arm.com>
References: <1420811657-21321-1-git-send-email-will.deacon@arm.com>
 <20150116140130.GQ7091@arm.com>
Message-ID: <20150119130940.GJ6343@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Fri, Jan 16, 2015 at 02:01:31PM +0000, Will Deacon wrote:
> I've not received any feedback on this revision of the series, but it's
> working well for me and Laurent showed that it works with his IOMMU too.
> 
> Joerg -- can I include this in my pull request for 3.20, or is there
> anything further you'd like me to address? The code is completely
> self-contained, so I wouldn't expect any impact on IOMMU drivers that
> don't explicitly use the new page table API.

The patch-set looks good to me. But with code generification in general,
what are the plans for other arm iommu drivers to adopt this?


	Joerg
