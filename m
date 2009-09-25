From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 25 Sep 2009 06:29:30 -0400
Subject: [PATCH 7/17] pxa: move pxa3xx_nand.h into plat directory
In-Reply-To: <f17812d70909221122m4424b281rad6e1aa6ef42f441@mail.gmail.com>
References: <771cded00909142307n48c09745g87dfc0a714f80dec@mail.gmail.com>
	<f17812d70909221122m4424b281rad6e1aa6ef42f441@mail.gmail.com>
Message-ID: <771cded00909250329n1c03056ck7c0c32688b86e19f@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 22, 2009 at 2:22 PM, Eric Miao <eric.y.miao@gmail.com> wrote:

> On Tue, Sep 15, 2009 at 2:07 PM, Haojian Zhuang
> <haojian.zhuang@gmail.com> wrote:
> > From 39a5943694214654908cb8754a964c772cd4e115 Mon Sep 17 00:00:00 2001
> > From: Haojian Zhuang <haojian.zhuang@marvell.com>
> > Date: Thu, 10 Sep 2009 13:55:23 +0800
> > Subject: [PATCH] pxa: move pxa3xx_nand.h into plat directory
> >
> > Since the same nand controller is shared between ARCH_PXA and ARCH_MMP.
> Move
> > the pxa3xx_nand.h from mach directory to plat directoy.
> >
> > Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
>
> Applied.
>

Updated the patch.

Thanks
Haojian
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20090925/a68e2443/attachment-0001.htm>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0006-pxa-move-pxa3xx_nand.h-into-plat-directory.patch
Type: text/x-patch
Size: 7932 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20090925/a68e2443/attachment-0001.bin>
