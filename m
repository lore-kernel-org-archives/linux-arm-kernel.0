From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 6 Mar 2012 14:10:57 +0800
Subject: [GIT revert][v3.4] revert 43de6a7dd in pxa/board branch
Message-ID: <CAN1soZzOSXbWMcJLGPyTqz1+BHHP9V=TjkM9z5+Vu75+BfwwqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Could you help to revert this commit in your pxa/board branch? I
attach the log information in below. Without this patch, gpio function
can't work in PXA25x/PXA27x. So I need to move them into fixes branch.

Best Regards
Haojian

commit 43de6a7dda6e9a7345e218e688f2092f991126f0
Author: Haojian Zhuang <haojian.zhuang@marvell.com>
Date:   Tue Feb 28 10:57:48 2012 +0800

    ARM: pxa: add dummy clock for pxa25x and pxa27x

    gpio-pxa driver is shared among arch-pxa and arch-mmp. Clock is the
    essential component on pxa3xx/pxa95x and arch-mmp. So we need to
    define dummy clock in pxa25x/pxa27x instead.

    Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
