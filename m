From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 10 Jan 2012 09:52:01 +0100
Subject: [PATCH v4 2/3] ARM: mmp: enable pinmux in mmp platform
In-Reply-To: <1325643995-20745-3-git-send-email-haojian.zhuang@marvell.com>
References: <1325643995-20745-1-git-send-email-haojian.zhuang@marvell.com>
 <1325643995-20745-3-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <CACRpkdbPk8GEvW7uewMXZcW7ghfry8X0Hgiz3uj4zOrpDgK4hQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 4, 2012 at 3:26 AM, Haojian Zhuang
<haojian.zhuang@marvell.com> wrote:

> Configuring pinmux in brownstone, aspenite & ttc dkb platform. The functions
> of pins are initialized in platform driver.

I tried to apply this patch but I can't, I suspect it is dependent on
some changes
in the PXA tree?

I can apply this after the merge window once PXA is pulled in and ready.

Yours,
Linus Walleij
