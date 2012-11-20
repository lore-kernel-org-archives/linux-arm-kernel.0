From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 20 Nov 2012 15:42:00 +0100
Subject: [PATCH v5 04/10] pinctrl: generic: add input schmitt disable
 parameter
In-Reply-To: <1352968600-15345-5-git-send-email-haojian.zhuang@gmail.com>
References: <1352968600-15345-1-git-send-email-haojian.zhuang@gmail.com>
 <1352968600-15345-5-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <CACRpkdbJcTsLbO+Y67WdTJPjp17t6Tp_D=c-pQ_KjXZHHmdETA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2012 at 9:36 AM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:

> In Marvell PXA/MMP silicons, input schmitt disable value is 0x40, not 0.
> So append new config parameter -- input schmitt disable.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>

I've applied this to the pinctrl tree, doesn't hurt anyone...

Yours,
Linus Walleij
