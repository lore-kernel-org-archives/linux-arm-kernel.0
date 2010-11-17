From: hzhuang1@marvell.com (Haojian Zhuang)
Date: Wed, 17 Nov 2010 03:09:10 -0800
Subject: [PATCH 9/9] ARM: pxa: add iwmmx support for PJ4
In-Reply-To: <1289991823-24677-9-git-send-email-haojian.zhuang@marvell.com>
References: <1289991823-24677-1-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-2-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-3-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-4-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-5-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-6-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-7-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-8-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-9-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <25B60CDC2F704E4E9D88FFD52780CB4C05986C77F4@SC-VEXCH1.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



>-----Original Message-----
>From: Haojian Zhuang [mailto:haojian.zhuang at marvell.com]
>Sent: 2010?11?17? 7:04 PM
>To: linux-arm-kernel at lists.infradead.org
>Cc: Haojian Zhuang; Zhou Zhu; Eric Miao; Nicolas Pitre
>Subject: [PATCH 9/9] ARM: pxa: add iwmmx support for PJ4
>
>iwmmxt is used in XScale, XScale3, Mohawk and PJ4 core. But the instructions
>of accessing CP0 and CP1 is changed in PJ4. Append more files to support
>iwmmxt in PJ4 core.
>
>Signed-off-by: Zhou Zhu <zzhu3@marvell.com>
>Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
>Cc: Eric Miao <eric.y.miao@gmail.com>
>Cc: Nicolas Pitre <nico@fluxnic.net>
>---
> arch/arm/Kconfig         |    4 +-
> arch/arm/kernel/Makefile |    1 +
> arch/arm/kernel/iwmmxt.S |   55 +++++++++++++++++++++++++++++++++++-------
>----
> 3 files changed, 45 insertions(+), 15 deletions(-)
>

Changelog:
1. Append missing pj4-cp0.c.

Thanks
Haojian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0009-ARM-pxa-add-iwmmx-support-for-PJ4.patch
Type: application/octet-stream
Size: 6981 bytes
Desc: 0009-ARM-pxa-add-iwmmx-support-for-PJ4.patch
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101117/8ddac871/attachment.obj>
