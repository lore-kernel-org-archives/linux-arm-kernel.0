From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 28 Nov 2011 10:22:53 +0100
Subject: [PATCH 7/7] ARM: mmp: enable pinmux on ttc dkb
In-Reply-To: <1322262544-7854-8-git-send-email-haojian.zhuang@marvell.com>
References: <1322262544-7854-1-git-send-email-haojian.zhuang@marvell.com>
 <1322262544-7854-8-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <CACRpkdY4ScYXVAoMGWw=ywYGot=uOySn4e0DRBmsvRCvDz76rw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 26, 2011 at 12:09 AM, Haojian Zhuang
<haojian.zhuang@marvell.com> wrote:

> Remove MFP operation. Use pinmux mapping instead.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>

As stated earlier, I think the new pinctrl platform data should be
passed in from
here, apart from that:

Acked-by: Linus Walleij <linus.walleij@linaro.org>

SInce you're the (co-)subarch maintainer for MMP I will merge this to pinctrl
as soon as the core driver is OK and you tell me to merge the rest of the
(ACK:ed) series.

Thanks,
Linus Walleij
