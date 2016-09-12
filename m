From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 12 Sep 2016 11:38:21 +0200
Subject: [GIT PULL 1/4] ARM: exynos: SoC/Mach for v4.9
In-Reply-To: <20160908192434.GA609@sam-MacBookPro>
References: <1472548739-20050-1-git-send-email-k.kozlowski@samsung.com>
 <1472548739-20050-5-git-send-email-k.kozlowski@samsung.com>
 <5635206.ooNAZCeQOe@wuerfel> <20160902163244.GB5534@kozik-lap>
 <08dfc5c7-e844-023c-b5a8-9996dfb403ff@samsung.com>
 <20160908192434.GA609@sam-MacBookPro>
 <CGME20160912093826eucas1p1ac2f1f08b49026f456b52f507d0de9f4@eucas1p1.samsung.com>
Message-ID: <9c7bb7bd-d347-03af-93c7-93534f43932d@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/08/2016 09:24 PM, Sam Van Den Berge wrote:
> Thanks for the suggestion and apologies for the late response. Last couple of 
> days I've been figuring out what this would involve and I decided that I want
> to give this a try. I found this patch series [1] that I'll use as an example.
> If I understand it correctly, I'll need to create a dma_slave_map and
> pass that via the platform data into the s3c24xx-dma driver. There I'll
> need to fill in the filter_map of the dma slave device. Right?

Yes, AFAIU that's what needs to be done.  Subsequently, related DMA
clients could be updated to not use dma_request_slave_channel_compat().

-- 
Thanks,
Sylwester
