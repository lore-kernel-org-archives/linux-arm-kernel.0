From: will.deacon@arm.com (Will Deacon)
Date: Tue, 9 Feb 2016 14:16:11 +0000
Subject: [PATCH 0/4] Miscellaneous ARM SMMU patches
In-Reply-To: <cover.1453830752.git.robin.murphy@arm.com>
References: <cover.1453830752.git.robin.murphy@arm.com>
Message-ID: <20160209141610.GP22874@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2016 at 06:06:33PM +0000, Robin Murphy wrote:
> Here's my current "miscellaneous SMMU enhancements" branch for your
> consideration. Patch #1 solves a subtle corner case that cropped up
> while exercising stage 1 context formats on the DMA330-MMU500 model;
> #3 will be wanted fairly soon for DMA ops integration so may as well
> get some exposure now; #2 and #4 are more nice-to-haves.

Cheers, Robin. I've queued #1 and #3 for 4.6. If you address the comments
on the other two, I can queue those as well.

Will
