From: ahemaily@gmail.com (Abdulrahman Hemaily)
Date: Sun, 30 Dec 2012 15:09:44 +0200
Subject: [PATCH 1/1] arm :omap :DMA: fix a bug on reserving the omap SDMA
 channels
In-Reply-To: <50DFDE2A.3070800@ti.com>
References: <1356813800-4705-1-git-send-email-ahemaily@gmail.com>
 <50DFDE2A.3070800@ti.com>
Message-ID: <CAJz1Lf2gDVo4n6fF=w1CdFCOWwWm4R5iheAS6EFnKocSJwW5Tg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sorry for the grammar mistakes.

Regards,,

On 30 December 2012 08:24, Santosh Shilimkar <santosh.shilimkar@ti.com>wrote:

> $subject
> s/arm:omap/ARM: OMAP:
>
>
> On Sunday 30 December 2012 02:13 AM, ahemaily at gmail.com wrote:
>
>> From: ahemaily <ahemaily@gmail.com>
>>
>> The variable  dma_lch_count  used for comparison
>>  (omap_dma_reserve_channels <= dma_lch_count)
>> before it initialized to the value from omap_dma_dev_attr : d->lch_count.
>>
> s/it/it is
>
>
>  I change the place of dma_lch_count initialization to be before the
>> comparison.
>>
>>  s/I change the place of dma_lch_count initialization to be before the
> comparison./ Initialize dma_lch_count before it is being used for
> comparison.
>
>
>  Signed-off-by: Abdelrahman Hemaily <ahemaily@gmail.com>
>> ---
>>
> Change looks good to my eyes o.w
>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121230/cfa88b30/attachment-0001.html>
