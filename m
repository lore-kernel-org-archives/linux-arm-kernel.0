From: holler@ahsoftware.de (Alexander Holler)
Date: Wed, 17 Sep 2014 12:56:24 +0200
Subject: [PATCH v2] ARM: dts: imx6dl: disable dma support for spi on
 i.mx6dl
In-Reply-To: <20140917085106.GB6369@Robin-OptiPlex-780>
References: <1410327012-31185-1-git-send-email-b38343@freescale.com>
 <5416D26A.4080707@ahsoftware.de> <20140916035204.GB20800@Robin-OptiPlex-780>
 <541805E3.6080003@ahsoftware.de> <20140917085106.GB6369@Robin-OptiPlex-780>
Message-ID: <541968D8.2060609@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 17.09.2014 10:51, schrieb Robin Gong:
> On Tue, Sep 16, 2014 at 11:41:55AM +0200, Alexander Holler wrote:
>> Am 16.09.2014 05:52, schrieb Robin Gong:
>>> On Mon, Sep 15, 2014 at 01:50:02PM +0200, Alexander Holler wrote:
>>>> Am 10.09.2014 07:30, schrieb Robin Gong:
>>>>> There is one weird data in rxfifo after one full rx/tx transfer
>>>>> done sometimes. It looks a design issue and hard to workaround
>>>>> totally, so disable dma functhion here. And will re-enable it
>>>>> once the root cause found.
>>>>
>>>> Hmm, I experience problems with DMA too but on uart3. I'm using the same
>>>> workaround for the uart (I've just commented out the dma entries in the DT).
>>>> The problem manifests itself here such, that brcm_patchram_plus
>>>> hangs while uploading the firmware to a BCM4330 connected at uart3
>>>> (reproducible).

(...)

> Yes, we just have fixed the BT issue over high speed UART last month. Suggest
> you trying our patches based on v3.10.

Thanks for the pointer. Will look if I will find these patches.

Regards,

Alexander Holler
