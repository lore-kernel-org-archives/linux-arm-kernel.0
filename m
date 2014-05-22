From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Thu, 22 May 2014 12:55:23 -0700
Subject: [linux-sunxi] Re: [PATCH v6 0/7] mfd: AXP20x: Add support for
 AXP202 and AXP209
In-Reply-To: <CAOQ7t2bqeQ35WxXKCRgj1ijJic=2w8++9idip4-f_LnP6Ucb6A@mail.gmail.com>
References: <1400528868-5971-1-git-send-email-carlo@caione.org>
 <20140520222307.GK12304@sirena.org.uk>
 <CAOQ7t2aBc5tFYk2MkfL9QqvFf5fcebwKtO97F3S=WdJ2uFE_jg@mail.gmail.com>
 <20140521091456.GB6679@lee--X1>
 <CAOQ7t2bqeQ35WxXKCRgj1ijJic=2w8++9idip4-f_LnP6Ucb6A@mail.gmail.com>
Message-ID: <20140522195523.GB7708@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 22, 2014 at 09:15:12PM +0200, Carlo Caione wrote:
> On Wed, May 21, 2014 at 11:14 AM, Lee Jones <lee.jones@linaro.org> wrote:
> >> >> This set of patches introduces the core driver and support for two different
> >> >> subsystems:
> >> >>       - Regulators
> >> >
> >> >>  .../ABI/testing/sysfs-driver-input-axp-pek         |  11 +
> >> >>  Documentation/devicetree/bindings/mfd/axp20x.txt   |  93 +++++++
> >> >>  .../devicetree/bindings/vendor-prefixes.txt        |   1 +
> >> >>  arch/arm/configs/multi_v7_defconfig                |   3 +
> >> >>  arch/arm/configs/sunxi_defconfig                   |   4 +
> >> >>  drivers/input/misc/Kconfig                         |  11 +
> >> >>  drivers/input/misc/Makefile                        |   1 +
> >> >>  drivers/input/misc/axp20x-pek.c                    | 281 +++++++++++++++++++++
> >> >>  drivers/mfd/Kconfig                                |  12 +
> >> >>  drivers/mfd/Makefile                               |   1 +
> >> >>  drivers/mfd/axp20x.c                               | 258 +++++++++++++++++++
> >> >>  include/linux/mfd/axp20x.h                         | 180 +++++++++++++
> >> >>  12 files changed, 856 insertions(+)
> >> >
> >> > The regulator changes don't appear to be showing up in the diffstat or
> >> > obviously in the series?
> >>
> >> Right. Cut-and-paste error.
> >> You have already applied the regulator patches so I didn't include
> >> them here (in theory I posted this series to be picked up by Lee).
> >
> > That's fine.  Just tell me which patches need to stay together and
> > which are able to be applied through their respective subsystem trees
> > separately.  Then, once I have all the Acks I can apply no problem.
> 
> Hi Lee,
> I'd say #1 for the MFD tree, #4 for the input subsystem, #2 #3 and #5
> are documentations, #6 and #7 defconfigs add-on.

I am fine with the input piece going through MFD tree, no need to split
it from the rest.

Thanks.

-- 
Dmitry
