From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 11 Mar 2016 07:47:06 +0530
Subject: [PATCH V14 4/9] dma: add Qualcomm Technologies HIDMA channel
 driver
In-Reply-To: <1454646882-24369-5-git-send-email-okaya@codeaurora.org>
References: <1454646882-24369-1-git-send-email-okaya@codeaurora.org>
 <1454646882-24369-5-git-send-email-okaya@codeaurora.org>
Message-ID: <20160311021706.GK11154@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 04, 2016 at 11:34:35PM -0500, Sinan Kaya wrote:
> This patch adds support for hidma engine. The driver consists of two
> logical blocks. The DMA engine interface and the low-level interface.
> The hardware only supports memcpy/memset and this driver only support
> memcpy interface. HW and driver doesn't support slave interface.
 
Applied after fixing subsystem name

-- 
~Vinod
