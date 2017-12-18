From: appanad@xilinx.com (Appana Durga Kedareswara Rao)
Date: Mon, 18 Dec 2017 06:50:55 +0000
Subject: [PATCH v7 0/6] dmaengine: xilinx_dma: Bug fixes
In-Reply-To: <20171218051931.GO18649@localhost>
References: <1512624067-13554-1-git-send-email-appanad@xilinx.com>
 <20171218051931.GO18649@localhost>
Message-ID: <CY1PR02MB169258BD3618415DDB30B3B8DC0E0@CY1PR02MB1692.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

>
>On Thu, Dec 07, 2017 at 10:51:01AM +0530, Kedareswara rao Appana wrote:
>> This patch series fixes below bugs in DMA and VDMA IP's
>> ---> Added channel idle checks in the driver before submitting the buffer
>descriptor to h/w.
>> ---> Fixes bug in Multi frame sotres handling in VDMA Fixes issues
>> ---> w.r.to multi frame descriptors submit with AXI DMA S2MM(recv) Side.
>> ---> Fixed kernel doc warnings in the driver.
>> ---> Fixed checkpatch errors in the driver.
>
>Applied after applying this to fix typo. You seriously need a decent spell checker in
>your editor

Thanks Vinod
Sorry for the noise around spell checks.
Will take care of it next time onwards thanks for pointing it out. 

Regards,
Kedar.

>
>-       /* This variable enusres that descripotrs are not
>-        * Submited when dma engine is in progress. This variable is
>-        * Added to avoid pollling for a bit in the status register to
>+       /* This variable ensures that descriptors are not
>+        * Submitted when dma engine is in progress. This variable is
>+        * Added to avoid polling for a bit in the status register to
>
>--
>~Vinod
>--
>To unsubscribe from this list: send the line "unsubscribe dmaengine" in the body
>of a message to majordomo at vger.kernel.org More majordomo info at
>http://vger.kernel.org/majordomo-info.html
