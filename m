From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 11 Apr 2014 23:12:31 -0400 (EDT)
Subject: [PATCH v2 1/2] ARM : DMA : remove useless information about
 DMA
In-Reply-To: <1397203252-22977-2-git-send-email-sdu.liu@huawei.com>
References: <1397203252-22977-1-git-send-email-sdu.liu@huawei.com>
 <1397203252-22977-2-git-send-email-sdu.liu@huawei.com>
Message-ID: <alpine.LFD.2.11.1404112252050.980@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Apr 2014, Liu Hua wrote:

> Because commit e9da6e9905e6 has remove custom consistent dma
> region. So the related variable and document should be removed
> 
> Signed-off-by: Liu Hua <sdu.liu@huawei.com>

Acked-by: Nicolas Pitre <nico@linaro.org>

Incidentally I sent an identical patch to RMK's patch system:

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8023/1

Either version is fine with me.


Nicolas
