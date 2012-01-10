From: hzhuang1@marvell.com (Haojian Zhuang)
Date: Tue, 10 Jan 2012 01:05:39 -0800
Subject: [PATCH v4 2/3] ARM: mmp: enable pinmux in mmp platform
In-Reply-To: <CACRpkdbPk8GEvW7uewMXZcW7ghfry8X0Hgiz3uj4zOrpDgK4hQ@mail.gmail.com>
References: <1325643995-20745-1-git-send-email-haojian.zhuang@marvell.com>
 <1325643995-20745-3-git-send-email-haojian.zhuang@marvell.com>,
 <CACRpkdbPk8GEvW7uewMXZcW7ghfry8X0Hgiz3uj4zOrpDgK4hQ@mail.gmail.com>
Message-ID: <25B60CDC2F704E4E9D88FFD52780CB4C060A87D719@SC-VEXCH1.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Do you mean the 1st & 2nd patch or the 3rd patch?

Thanks
Haojian
________________________________________
From: Linus Walleij [linus.walleij at linaro.org]
Sent: Tuesday, January 10, 2012 4:52 PM
To: Haojian Zhuang
Cc: swarren at nvidia.com; linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; eric.y.miao at gmail.com; linux at arm.linux.org.uk; arnd at arndb.de
Subject: Re: [PATCH v4 2/3] ARM: mmp: enable pinmux in mmp platform

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
