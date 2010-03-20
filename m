From: eric.y.miao@gmail.com (Eric Miao)
Date: Sat, 20 Mar 2010 15:26:16 +0800
Subject: [PATCH 3/6] mmp: support ssp in pxa168
In-Reply-To: <771cded01003190853r54efc7f0hfb1c7b0a5a44d63f@mail.gmail.com>
References: <771cded01003190853r54efc7f0hfb1c7b0a5a44d63f@mail.gmail.com>
Message-ID: <f17812d71003200026v5f37ff58i10008e79012fb33f@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 19, 2010 at 11:53 PM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> From 7278f62e2f33a4534c4325b0e6eb567402b1b8c4 Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Wed, 17 Mar 2010 15:42:53 -0400
> Subject: [PATCH] [ARM] mmp: support ssp in pxa168
>
> Support ssp devices in PXA168. PXA168 could reuse the code of PXA SSP.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> ---
> ?arch/arm/mach-mmp/include/mach/irqs.h ? ? ?| ? 10 +++---
> ?arch/arm/mach-mmp/include/mach/pxa168.h ? ?| ? 21 ++++++++++++
> ?arch/arm/mach-mmp/include/mach/regs-apbc.h | ? 10 +++---
> ?arch/arm/mach-mmp/include/mach/regs-mpmu.h | ? 48 ++++++++++++++++++++++++++++

What's the matter with regs-mpmu.h here ??

I've removed this file and merged the other relevant changes into 'ssp_cleanup',
please help check.
