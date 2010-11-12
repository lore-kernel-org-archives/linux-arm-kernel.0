From: hzhuang1@marvell.com (Haojian Zhuang)
Date: Fri, 12 Nov 2010 00:50:37 -0800
Subject: [PATCH 05/11] ARM: pxa: support pxa95x
In-Reply-To: <1289546260-6208-5-git-send-email-haojian.zhuang@marvell.com>
References: <1289546260-6208-1-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-2-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-3-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-4-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-5-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <25B60CDC2F704E4E9D88FFD52780CB4C05986C7027@SC-VEXCH1.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



>-----Original Message-----
>From: Haojian Zhuang [mailto:haojian.zhuang at marvell.com]
>Sent: 2010?11?12? 3:18 PM
>To: linux-arm-kernel at lists.infradead.org
>Cc: Haojian Zhuang; Eric Miao
>Subject: [PATCH 05/11] ARM: pxa: support pxa95x
>
>The core of PXA955 is PJ4. Add new PJ4 support. And add new macro
>CONFIG_PXA95x.
>
>Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
>Cc: Eric Miao <eric.y.miao@gmail.com>
>---

Changelog:
1. Remove pxa95x_clear_reset_status() in pxa95x.c
2. Remove pxa95x_clear_reset_status() definition in generic.h

Thanks
Haojian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0005-ARM-pxa-support-pxa95x.patch
Type: application/octet-stream
Size: 28875 bytes
Desc: 0005-ARM-pxa-support-pxa95x.patch
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101112/b430ec9b/attachment-0001.obj>
