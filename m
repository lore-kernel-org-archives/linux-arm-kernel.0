From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 21 Aug 2014 13:11:10 -0700
Subject: [PATCH v7 02/11] power/restart: Call machine_restart instead of
 arm_pm_restart
In-Reply-To: <CAD=FV=XMBegDcPWM+sG4S64ZC6KEzKA-ykpEJrcGo2db+P0VLg@mail.gmail.com>
References: <1408495538-27480-1-git-send-email-linux@roeck-us.net>
 <1408495538-27480-3-git-send-email-linux@roeck-us.net>
 <CAD=FV=Va8UrpDCLjFQJ6j-K0C3v7NPfifaJGtReCkUEu3x0mLg@mail.gmail.com>
 <20140821044230.GA14609@roeck-us.net>
 <CAD=FV=XMBegDcPWM+sG4S64ZC6KEzKA-ykpEJrcGo2db+P0VLg@mail.gmail.com>
Message-ID: <20140821201110.GA11382@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 21, 2014 at 12:30:44PM -0700, Doug Anderson wrote:
> Guenter,
> 
> On Wed, Aug 20, 2014 at 9:42 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> > On Wed, Aug 20, 2014 at 09:10:31PM -0700, Doug Anderson wrote:
> >> Guenter,
> >>
> >> On Tue, Aug 19, 2014 at 5:45 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> >> > machine_restart is supported on non-ARM platforms, and and ultimately calls
> >> > arm_pm_restart, so dont call arm_pm_restart directly but use the more
> >> > generic function.
> >> >
> >> > Cc: Russell King <linux@arm.linux.org.uk>
> >>
> >> Do you need to submit this to his patch tracker to get him to pick it
> >> up?  How are you envisioning that this series land?  It crosses a lot
> >> of boundaries so I guess will need a reasonable amount of coordination
> >> between maintainers...
> >>
> >>
> > If I get an Acked-by: from all maintainers, I could send a pull request
> > to Linus directly. How do I send a patch to Russell's patch tracker ?
> > I thought I copied all mailing lists suggested by get_maintainer.pl,
> > but maybe I missed one.
> 
> Ah, OK.  Perhaps it's best to ignore me, then.  ;)  FYI: Russell's

No, I appreciate the information.

> Patch System is at <http://www.arm.linux.org.uk/developer/patches/>
> and is used for getting individual patches into branches maintained by
> Russel.  If you're just going to send a pull request for the series
> then I don't think you need it.
> 
I copied both linux-arm-kernel and Russell himself, so hopefully he is aware
of the series and can let me know if he wants me to make any further changes
to it, if it is ready to go, or if I need to do anything else.

Thanks,
Guenter
