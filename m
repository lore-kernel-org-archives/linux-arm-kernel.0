From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 28 Nov 2011 12:49:19 +0000
Subject: [PATCH 3/7] ARM: pxa: enable pinmux in pxa pwm
In-Reply-To: <CACRpkdbQEHjwF0mAJf3hCX7VdW0YBcHH0z6dFus-rC09_e08vw@mail.gmail.com>
References: <1322262544-7854-1-git-send-email-haojian.zhuang@marvell.com>
 <1322262544-7854-4-git-send-email-haojian.zhuang@marvell.com>
 <CACRpkdbQEHjwF0mAJf3hCX7VdW0YBcHH0z6dFus-rC09_e08vw@mail.gmail.com>
Message-ID: <20111128124919.GC11432@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 28, 2011 at 10:18:25AM +0100, Linus Walleij wrote:
> On Sat, Nov 26, 2011 at 12:09 AM, Haojian Zhuang
> <haojian.zhuang@marvell.com> wrote:
> 
> > From: Haojian Zhuang <hzhuang1@hexinfolabs.org>
> >
> > Add pinmux operations in pxa pwm driver.
> >
> > Signed-off-by: Haojian Zhuang <hzhuang1@hexinfolabs.org>
> 
> Same comment as for the serial driver,
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> I need one of the PXA maintainers (Eric, Russell) ACK to merge
> it through the pinctrl tree.

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
