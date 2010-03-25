From: jassisinghbrar@gmail.com (jassi brar)
Date: Thu, 25 Mar 2010 14:34:41 +0900
Subject: [PATCH v2] PL330: Add PL330 DMA controller driver
In-Reply-To: <4BAAD5BB.7050101@samsung.com>
References: <4BAAD5BB.7050101@samsung.com>
Message-ID: <1b68c6791003242234h106d9530p12b5a046a906227e@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 25, 2010 at 12:17 PM, Joonyoung Shim
<jy0922.shim@samsung.com> wrote:
> The PL330 is currently the dma controller using at the S5PC1XX arm SoC.
> This supports DMA_MEMCPY and DMA_SLAVE.
>
> The datasheet for the PL330 can find below url:
> http://infocenter.arm.com/help/topic/com.arm.doc.ddi0424a/DDI0424A_dmac_pl330_r0p0_trm.pdf
>
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> ---
> Change log:
>
> v2: Convert into an amba_device driver.
> ? ?Code clean and update from v1 patch review.

[CC'ing Russell and Ben as stakeholders]

Dear Maintainers

I too have been writing a driver for PL330 after taking into account the
suggestions of Russell, Ben and other participants of the thread
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-February/009856.html

If you don't think this driver conflicts with the theme of the thread,
may I ask you
to please put this driver on hold until you checkout my implementation
of solution
to the issue... which should be soon.

Regards,
Jaswinder Singh
Solution-1 Group
Linux Kernel Team
System LSI Division
Samsung Electronics Co., Ltd.
