From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 27 May 2014 16:16:39 +0200
Subject: [GIT PULL] ARM: Keystone reset driver 3.16
In-Reply-To: <53849C05.8090004@ti.com>
References: <1400880597-7516-1-git-send-email-santosh.shilimkar@ti.com>
 <1401175584.4090.22.camel@paszta.hi.pengutronix.de> <53849C05.8090004@ti.com>
Message-ID: <4799350.My62BxqHfR@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 27 May 2014 10:07:01 Santosh Shilimkar wrote:
> 
> On Tuesday 27 May 2014 03:26 AM, Philipp Zabel wrote:
> > Hi Olof, Santosh,
> > 
> > Am Montag, den 26.05.2014, 14:26 -0700 schrieb Olof Johansson:
> >> On Fri, May 23, 2014 at 05:29:57PM -0400, Santosh Shilimkar wrote:
> >>> Hi Arm-soc folks,
> >>>
> >>> Please pull below keystone reset driver for 3.16 . To avoid merge conflict
> >>> with earlier keystone-soc pull request[1], I have based the subject pull
> >>> request on top of it. It merges cleanly with arm-soc 'next/soc2' head. Please
> >>> apply it against 'next/soc2'. Thanks 
> >>
> >> Hi,
> >>
> >> I notice this driver doesn't have an ack from Philipp Zabel (cc:d here). That
> >> would be appropriate.
> >
> We asked about ack, split series options from reset folks but didn't hear back.
> Since the series has been on the list for almost 3 merge windows now, I asked
> Arnd how to go about it and he suggested to send it via arm-soc. Should have
> clarified it in pull request.

Olof, note that this is a driver for system reset, i.e. drivers/power/reset, not
for resetting individual devices as drivers/reset does. Philipp maintains the
latter, but AFAIK he's not involved in the drivers/power stuff.

	Arnd
