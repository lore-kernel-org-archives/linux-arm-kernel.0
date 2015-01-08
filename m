From: balbi@ti.com (Felipe Balbi)
Date: Thu, 8 Jan 2015 15:58:39 -0600
Subject: [PATCH] ARM: omap2plus_defconfig: Enable misc options for
 BeagleBoard-X15 platform
In-Reply-To: <CAGo_u6p-6EuZR8JC2Z=o1t9EgXKQnH6R9mYrfLxrsD7sYXdAxg@mail.gmail.com>
References: <1420751680-21230-1-git-send-email-nm@ti.com>
 <20150108212538.GU31926@saruman>
 <CAGo_u6p-6EuZR8JC2Z=o1t9EgXKQnH6R9mYrfLxrsD7sYXdAxg@mail.gmail.com>
Message-ID: <20150108215839.GV31926@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

On Thu, Jan 08, 2015 at 03:49:11PM -0600, Nishanth Menon wrote:
> On Thu, Jan 8, 2015 at 3:25 PM, Felipe Balbi <balbi@ti.com> wrote:
> > Hi,
> >
> > On Thu, Jan 08, 2015 at 03:14:40PM -0600, Nishanth Menon wrote:
> >> @@ -205,6 +206,7 @@ CONFIG_PINCTRL_SINGLE=y
> >>  CONFIG_DEBUG_GPIO=y
> >>  CONFIG_GPIO_SYSFS=y
> >>  CONFIG_GPIO_TWL4030=y
> >> +CONFIG_GPIO_PALMAS=y
> >
> > other than the power button, do you have anything else attached to a
> > palmas GPIO ? We might not need this for boot.
> we dont, but setting it to 'm'
> "warning: symbol value 'm' invalid for GPIO_PALMAS"

alright, should've checked. Guess we will need to patch that up at some
point.

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150108/fe9feaa1/attachment-0001.sig>
