From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 21 Sep 2015 20:06:11 +0800
Subject: [PATCH 2/5] pinctrl: berlin: add the berlin4ct pinctrl driver
In-Reply-To: <55FF09D5.6090707@gmail.com>
References: <1442656956-5740-1-git-send-email-jszhang@marvell.com>
 <1442656956-5740-3-git-send-email-jszhang@marvell.com>
 <55FF09D5.6090707@gmail.com>
Message-ID: <20150921200611.5e55e9d5@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sebastian,

On Sun, 20 Sep 2015 21:32:37 +0200
Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:

> > +	BERLIN_PINCTRL_GROUP("SM_TDO", 0x0, 0x3, 0x12,
> > +			BERLIN_PINCTRL_FUNCTION(0x0, "sm_tdo"),
> > +			BERLIN_PINCTRL_FUNCTION(0x1, "sm_gpio2")),
> > +	BERLIN_PINCTRL_GROUP("SM_URT0_TXD", 0x0, 0x3, 0x15,
> > +			BERLIN_PINCTRL_FUNCTION(0x0, "sm_urt0_txd"),  
> 
> Please avoid abbreviating acronyms even more, we can afford the
> few extra bytes.

In the 2nd version, I kept using HW names, for example:

1. "urt0" as the function name,

2. "SM_URT0_TXD" as the pin name (group name)

to keep sync with HW, especially the pin names are the same as HW's, because
that's what HW doc, sch, etc. call them. IMHO, using a different name with HW
is not a good idea, what do you think?

Thanks,
Jisheng
