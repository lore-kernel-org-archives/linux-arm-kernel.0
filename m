From: jg1.han@samsung.com (Jingoo Han)
Date: Fri, 26 Jul 2013 08:17:58 +0900
Subject: [PATCH] mfd: max8925: fix dt code for backlight
In-Reply-To: <CAOesGMh5-aRR+eZVimNnZJ++f74tbURWOeri-46GNQfK_r3JuA@mail.gmail.com>
References: <1374680547-5336-1-git-send-email-olof@lixom.net>
 <000401ce88d4$33773de0$9a65b9a0$@samsung.com>
 <CAOesGMh5-aRR+eZVimNnZJ++f74tbURWOeri-46GNQfK_r3JuA@mail.gmail.com>
Message-ID: <000f01ce898d$333a5ce0$99af16a0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, July 26, 2013 6:01 AM, Olof Johansson wrote:
> On Wed, Jul 24, 2013 at 6:13 PM, Jingoo Han <jg1.han@samsung.com> wrote:
> > On Thursday, July 25, 2013 12:42 AM, Olof Johansson wrote:
> >>
> >> The device-tree enablement for max8925 has several problems, but besides
> >> the bindings being wrong (and not having seen review) there's also some
> >> bad coding practices on how to fill in the platform_data from device tree.
> >>
> >> I came across this since it causes a warning when compiling
> >> mmp2_defconfig, and instead of doing the minimal fix to silence the
> >> warning, I restructured the code a bit.
> >>
> >> This silences the warning:
> >> drivers/video/backlight/max8925_bl.c: In function 'max8925_backlight_probe':
> >> drivers/video/backlight/max8925_bl.c:177:3: warning: statement with no effect [-Wunused-value]
> >>
> >> Note that the bindings themselves need to be revisited too, but that will
> >> affect more than just the backlight driver and is best done separately;
> >> this just fixes the bad code for the backlight driver.
> >>
> >> Signed-off-by: Olof Johansson <olof@lixom.net>
> >> ---
> >>
> >> Richard, Jingoo, this would be good to see go into 3.11 if you're
> >> comfortable with it.
> >
> > CC'ed Andrew Morton
> >
> >
> > Hi Olof Johansson,
> >
> > Currently, there is not git tree for Backlight subsystem.
> > I hope that this would go into 3.11 through one of other trees
> > with my Ack.
> >
> > If not, it will go into 3.12-rc1 through mm-tree.
> >
> > Acked-by: Jingoo Han <jg1.han@samsung.com>
> 
> Ok, if you don't mind I can take it through arm-soc for 3.11 with your ack then. 

Hi Olof Johansson,

Sure, no problem.
If you take it through arm-soc for 3.11 with my ACK, it will be good.
Thank you for caring this. :)

Best regards,
Jingoo Han
