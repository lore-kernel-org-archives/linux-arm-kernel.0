From: chunfeng.yun@mediatek.com (chunfeng yun)
Date: Wed, 13 Jul 2016 13:40:11 +0800
Subject: Add MediaTek USB3 DRD Driver
In-Reply-To: <1465960040-768-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1465960040-768-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <1468388411.29220.4.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe:

Could you please give me some suggestions if you have already reviewed
some codes.

Thanks a lot.


On Wed, 2016-06-15 at 11:07 +0800, Chunfeng Yun wrote:
> From 48552e96e4e33f8830cb6a59154fe148425532fd Mon Sep 17 00:00:00 2001
> From: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Date: Wed, 15 Jun 2016 10:58:10 +0800
> Subject: [PATCH v4,0/5] Add MediaTek USB3 DRD Driver
> 
> These patches introduce the MediaTek USB3 dual-role controller
> driver.
> 
> The driver can be configured as Dual-Role Device (DRD),
> Peripheral Only and Host Only (xHCI) modes. It works well
> with Mass Storage, RNDIS and g_zero on FS/HS and SS. And it is
> tested on MT8173 platform which only contains USB2.0 device IP,
> and on MT6290 platform which contains USB3.0 device IP.
> 
> Change in v4:
> 1. fix build errors on non-mediatek platforms
> 2. provide manual dual-role switch via debugfs instead of sysfs
> 

> --
> 1.7.9.5
> 
> 
