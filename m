From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Sun, 02 Mar 2014 00:59:25 +0100
Subject: [PATCH] PM / Sleep: Set pm_generic functions to NULL for
 !CONFIG_PM_SLEEP
In-Reply-To: <CAPDyKFrhyBZV6yUogxTQPdFPg=1R3UZ0Yr_VfXrTivMaNeGVEQ@mail.gmail.com>
References: <1392811761-28201-1-git-send-email-ulf.hansson@linaro.org>
 <20140219122715.GB32069@amd.pavel.ucw.cz>
 <CAPDyKFrhyBZV6yUogxTQPdFPg=1R3UZ0Yr_VfXrTivMaNeGVEQ@mail.gmail.com>
Message-ID: <1517514.5FC3TgtPH4@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, February 27, 2014 09:29:31 AM Ulf Hansson wrote:
> On 19 February 2014 13:27, Pavel Machek <pavel@ucw.cz> wrote:
> > On Wed 2014-02-19 13:09:21, Ulf Hansson wrote:
> >> Previously only a subset of the functions were defined and set to NULL
> >> while !CONFIG_PM_SLEEP. Let's make them all available so they can be
> >> used no matter of CONFIG_PM_SLEEP or not.
> >>
> >> Cc: Russell King <linux@arm.linux.org.uk>
> >> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >
> > Reviewed-by: Pavel Machek <pavel@ucw.cz>
> >
> 
> Hi Rafael,
> 
> If you have no concern with this one, I would appreciate if it could
> go in for 3.15.
> 
> I have some patches for the amba bus (driver/amba/bus.c) that would
> require these pointers to be available.

I've queued it up for 3.15, thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
