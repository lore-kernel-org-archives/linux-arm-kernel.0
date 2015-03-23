From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Mon, 23 Mar 2015 21:35:36 +0800
Subject: [PATCH 00/15] iommu: Move domain allocation into drivers
In-Reply-To: <20150323114921.GM4441@8bytes.org>
References: <1422316305-19216-1-git-send-email-joro@8bytes.org>
 <1426843458.23931.17.camel@mtksdaap41>  <20150323114921.GM4441@8bytes.org>
Message-ID: <1427117736.18677.8.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-03-23 at 12:49 +0100, Joerg Roedel wrote:
> Hi Yingjoe,
> 
> On Fri, Mar 20, 2015 at 05:24:18PM +0800, Yingjoe Chen wrote:
> > What's the status of this patchset?
> > While porting MTK IOMMU driver[1], we need to use a global variable
> > because we need to do dma_alloc_coherent in our domain_init. I think we
> > can remove that global variable if we base on this series.
> 
> I plan to send out a new version this week.

Hi Joerg,

That's great.
Thanks for the update :)

Joe.C
