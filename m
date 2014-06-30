From: antoine.tenart@free-electrons.com (Antoine =?iso-8859-1?Q?T=E9nart?=)
Date: Mon, 30 Jun 2014 15:39:48 +0200
Subject: [PATCH v2 07/12] usb: chipidea: add a generic driver
In-Reply-To: <000001cf8f9a$3045f3a0$90d1dae0$%han@samsung.com>
References: <1403606121-6368-1-git-send-email-antoine.tenart@free-electrons.com>
 <1403606121-6368-8-git-send-email-antoine.tenart@free-electrons.com>
 <000001cf8f9a$3045f3a0$90d1dae0$%han@samsung.com>
Message-ID: <20140630133948.GB11880@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Jun 24, 2014 at 07:51:01PM +0900, Jingoo Han wrote:
> On Tuesday, June 24, 2014 7:35 PM, Antoine Tenart wrote:
> > 
> > Add a generic ChipIdea driver, with optional PHY and clock, to support
> > ChipIdea controllers that doesn't need specific functions.
> 
> s/doesn't/don't
> 
> > 
> > Needed for the Marvell Berlin SoCs SUB controllers.
> 
> s/SUB/USB

Right, I'll fix these.

> 
> > +
> > +MODULE_DESCRIPTION("Generic ChipIdea HDRC USB binding");
> > +MODULE_AUTHOR("Antoine T?nart <antoine.tenart@free-electrons.com>");
> > +MODULE_LICENSE("GPL");
> 
> How about "GPL v2"?

Well, "GPL" stands for "GNU Public License v2 or later" as documented
in:
http://lxr.free-electrons.com/source/include/linux/module.h#L100

Is there a reason I should use "GPLv2"? Or is this a best practice?

Thanks!

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
