From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 26 Jan 2017 15:11:14 +0100
Subject: [PATCHv4 3/5] pinctrl: mvebu: pinctrl driver for 98DX3236 SoC
In-Reply-To: <6eb30a9ec3cf4fc9971f33742f334980@svr-chch-ex1.atlnz.lc>
References: <20170113091222.7132-1-chris.packham@alliedtelesis.co.nz>
 <20170113091222.7132-4-chris.packham@alliedtelesis.co.nz>
 <20170119100244.GX27312@n2100.armlinux.org.uk>
 <c873040cba1a4d5aa15dbaf3c5cc44e0@svr-chch-ex1.atlnz.lc>
 <6eb30a9ec3cf4fc9971f33742f334980@svr-chch-ex1.atlnz.lc>
Message-ID: <CACRpkdZ2M4g+wFMADsvx_yBV6ZjsZz33VLH4vspO-sd9hZ6Qhw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 23, 2017 at 9:18 AM, Chris Packham
<Chris.Packham@alliedtelesis.co.nz> wrote:

> I noticed the mvebu pinctrl series isn't in Linus's (Torvalds) tree. Is
> this on the cards for v4.10 or is it waiting for the next merge window?

Next merge window.

> In other words should I send v5 or my series now or wait for this to be
> merged so I can rebase on top of it?

Rebase it on my devel branch in the pin control tree:
git clone git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
cd linux-pinctrl
git checkout -b devel origin/devel
[git am .. / git pull old-branch]

Yours,
Linus Walleij
