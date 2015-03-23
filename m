From: joro@8bytes.org (Joerg Roedel)
Date: Mon, 23 Mar 2015 12:49:21 +0100
Subject: [PATCH 00/15] iommu: Move domain allocation into drivers
In-Reply-To: <1426843458.23931.17.camel@mtksdaap41>
References: <1422316305-19216-1-git-send-email-joro@8bytes.org>
 <1426843458.23931.17.camel@mtksdaap41>
Message-ID: <20150323114921.GM4441@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yingjoe,

On Fri, Mar 20, 2015 at 05:24:18PM +0800, Yingjoe Chen wrote:
> What's the status of this patchset?
> While porting MTK IOMMU driver[1], we need to use a global variable
> because we need to do dma_alloc_coherent in our domain_init. I think we
> can remove that global variable if we base on this series.

I plan to send out a new version this week.


	Joerg
