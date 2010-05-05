From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 5 May 2010 13:49:59 +0800
Subject: [PATCH 02/10] [ARM] pxa: rename mfp-pxa930 to mfp-pxa9xx
In-Reply-To: <r2k771cded01004290116ra5f37bf6g90fc0539da4e2ce9@mail.gmail.com>
References: <r2k771cded01004290116ra5f37bf6g90fc0539da4e2ce9@mail.gmail.com>
Message-ID: <n2rf17812d71005042249lb15821f7nbe0a95b0f836f91c@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 29, 2010 at 4:16 PM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> From 485d1236f1782dcd61f6f4b45c78d91f16876521 Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Thu, 11 Mar 2010 15:21:29 -0500
> Subject: [PATCH] [ARM] pxa: rename mfp-pxa930 to mfp-pxa9xx
>
> Lots of pins are same on both PXA930 and PXA950. Rename mfp-pxa930.h to
> mfp-pxa9xx.h.
>

I'd prefer pxa950 use pxa930 directly, as pxa310 vs pxa300, for the
reason of existing pxa910 model (Sigh ... naming mess again).
