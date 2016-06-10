From: felipe.balbi@linux.intel.com (Felipe Balbi)
Date: Fri, 10 Jun 2016 12:27:11 +0300
Subject: Add MediaTek USB3 DRD Driver
In-Reply-To: <1465543962-11678-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1465543962-11678-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <8760th75sg.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Chunfeng Yun <chunfeng.yun@mediatek.com> writes:
> From 8fdc924cecf0ca14da6e8aba360501e53437e548 Mon Sep 17 00:00:00 2001
> From: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Date: Fri, 10 Jun 2016 15:20:20 +0800
> Subject: [PATCH 0/5] Add MediaTek USB3 DRD Driver
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
> Change in v3:
> 1. fix some typo error
> 2. rename mtu3.txt to mt8173-mtu3.txt
>
> Change in v2:
> 1. modify binding docs according to suggestions
> 2. modify some comments and remove some dummy blank lines
> 3. fix memory leakage

I don't see anything inherently wrong with this series. But keep in mind
I don't have HW to test. I can take the peripheral driver in a few days.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160610/f4fc2408/attachment-0001.sig>
