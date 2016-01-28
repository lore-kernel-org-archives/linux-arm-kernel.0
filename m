From: biao.huang@mediatek.com (biao huang)
Date: Fri, 29 Jan 2016 06:08:40 +0800
Subject: [PATCH v4 0/5] pinctrl: mediatek: add pinctrl/GPIO/EINT driver
 for mt2701
In-Reply-To: <CACRpkdbxpc19bdzGDUDoqseTA-TW3V8dAA4Oe+G860qTsHd-dQ@mail.gmail.com>
References: <1453857883-28436-1-git-send-email-biao.huang@mediatek.com>
 <CACRpkdbxpc19bdzGDUDoqseTA-TW3V8dAA4Oe+G860qTsHd-dQ@mail.gmail.com>
Message-ID: <1454018920.14802.41.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,
	[PATCH v4 1/5] pinctrl: mediatek: fix direction control issue
	this patch is also a pinctrl patch, and it seems not merged in
devel-mt2701 branch.

Best Regards!
Yours,
Biao Huang

On Thu, 2016-01-28 at 11:20 +0100, Linus Walleij wrote:
> On Wed, Jan 27, 2016 at 2:24 AM, Biao Huang <biao.huang@mediatek.com> wrote:
> 
> > Change in v4:
> > 1. create a sperate patch for direction setting of input-enable/disalbe and input-schmitt-enable/disable.
> 
> So I've merged the patches affecting drivers/pinctrl on the special
> devel-mt2701 branch, so the ARM SoC people can pull this into
> their tree to resolve dependencies on the pinctrl include
> in include/dt-bindings.
> https://git.kernel.org/cgit/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=devel-mt2701
> 
> The rest of the patches should go into ARM SoC, so they can
> just pull this branch in and apply that stuff on top.
> 
> Allow this a few days, I am also waiting for the add-on patches
> from John Crispin to come in, please include John in the
> feedback loop.
> 
> Yours,
> Linus Walleij
