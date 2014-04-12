From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 11 Apr 2014 23:31:58 -0400 (EDT)
Subject: [PATCH v2 1/2] ARM : DMA : remove useless information about
 DMA
In-Reply-To: <alpine.LFD.2.11.1404112252050.980@knanqh.ubzr>
References: <1397203252-22977-1-git-send-email-sdu.liu@huawei.com>
 <1397203252-22977-2-git-send-email-sdu.liu@huawei.com>
 <alpine.LFD.2.11.1404112252050.980@knanqh.ubzr>
Message-ID: <alpine.LFD.2.11.1404112330300.980@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Apr 2014, Nicolas Pitre wrote:

> On Fri, 11 Apr 2014, Liu Hua wrote:
> 
> > Because commit e9da6e9905e6 has remove custom consistent dma
> > region. So the related variable and document should be removed
> > 
> > Signed-off-by: Liu Hua <sdu.liu@huawei.com>
> 
> Acked-by: Nicolas Pitre <nico@linaro.org>
> 
> Incidentally I sent an identical patch to RMK's patch system:
> 
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8023/1
> 
> Either version is fine with me.

Actually mine is slightly better as I also removed the entry covering 
0xff000000 to 0xffbfffff which is no longer used either.


Nicolas
