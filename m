From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 26 Jul 2017 22:33:01 +0530
Subject: [PATCH 0/6] Broadcom SBA-RAID driver improvements
In-Reply-To: <1501047404-14456-1-git-send-email-anup.patel@broadcom.com>
References: <1501047404-14456-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <20170726170259.GH3053@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 26, 2017 at 11:06:38AM +0530, Anup Patel wrote:
> This patchset does various improvments to Broadcom SBA-RAID
> driver and also adds SBA-RAID DT nodes for Stingray SOC.
> 
> The patches are based on "[PATCH v2 0/7] FlexRM driver improvements"
> and can also be found at sba-raid-imp-v1 branch of
> https://github.com/Broadcom/arm64-linux.git

and i cant apply this series without these?

> 
> Anup Patel (6):
>   dma: bcm-sba-raid: Improve memory allocation in SBA RAID driver
>   dma: bcm-sba-raid: Peek mbox when we are left with no free requests
>   dma: bcm-sba-raid: pre-ack async tx descriptor
>   dma: bcm-sba-raid: Break sba_process_deferred_requests() into two
>     parts
>   dma: bcm-sba-raid: Add debugfs support

why are these tagged dma, I have told you explcitly to fix this!!

>   arm64: dts: Add SBA-RAID DT nodes for Stingray SoC
> 
>  .../boot/dts/broadcom/stingray/stingray-fs4.dtsi   |  64 +++
>  drivers/dma/bcm-sba-raid.c                         | 527 ++++++++++++---------
>  2 files changed, 364 insertions(+), 227 deletions(-)
> 
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
~Vinod
