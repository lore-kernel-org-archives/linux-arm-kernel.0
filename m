From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Tue, 14 Aug 2012 12:02:32 +0800
Subject: [PATCH v2 1/4] dmaengine: mmp-pdma support
In-Reply-To: <201208131312.15180.arnd@arndb.de>
References: <1344395701-30888-1-git-send-email-zhangfei.gao@marvell.com>
 <1344395701-30888-2-git-send-email-zhangfei.gao@marvell.com>
 <201208131312.15180.arnd@arndb.de>
Message-ID: <CAMj5Bkh0VvWLXdfgtOVcKudv+FdRDYJoR1=+V-EeJLRA5Aox6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
>> +Required properties:
>> +- compatible: Should be "marvell,pdma-1.0"
>> +- reg: Should contain DMA registers location and length.
>> +- interrupts: Either contain all of the per-channel DMA interrupts
>> +               or one irq for pdma device
>> +- dma-channels: Number of DMA channels supported by the controller.
>
> I think the last one should be "#dma-channels", not "dma-channels", since it's
> counting the channels. I think we use the "#" version in the preliminary binding
> for the generic dma channel assignment in DT.
>
>         Arnd
>

Thanks Arnd for careful review, will update with "#dma-channels" in v3.

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
