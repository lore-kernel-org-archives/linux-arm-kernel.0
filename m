From: vinod.koul@intel.com (Vinod Koul)
Date: Sun, 20 Mar 2016 15:09:27 +0530
Subject: [PATCH V15 0/4] dma: add Qualcomm Technologies HIDMA driver
In-Reply-To: <1457732994-11175-1-git-send-email-okaya@codeaurora.org>
References: <1457732994-11175-1-git-send-email-okaya@codeaurora.org>
Message-ID: <20160320093926.GM2490@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 11, 2016 at 04:49:50PM -0500, Sinan Kaya wrote:
> 
> Sinan Kaya (4):
>   dma: qcom_hidma: implement lower level hardware interface
>   dma: qcom_hidma: add debugfs hooks
>   dma: qcom_hidma: add support for object hierarchy
>   dma: qcom_hidma: read the channel id from HW

Any reason why you insist on using subsystem name as dma even when asked to
change..

-- 
~Vinod
