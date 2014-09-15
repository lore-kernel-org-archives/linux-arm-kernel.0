From: grant.likely@linaro.org (Grant Likely)
Date: Mon, 15 Sep 2014 15:57:35 -0700
Subject: [RFC PATCH for Juno 0/2] Drivers for Juno to boot from ACPI
In-Reply-To: <3840839.IPB3Ru8Evk@wuerfel>
References: <1409583961-7466-1-git-send-email-hanjun.guo@linaro.org>
 <353732273.2TKdyNJ83M@wuerfel> <540EA446.7010200@redhat.com>
 <3840839.IPB3Ru8Evk@wuerfel>
Message-ID: <20140915225735.1C5A9C40B84@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 09 Sep 2014 12:55:09 +0200, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 09 September 2014 02:55:02 Jon Masters wrote:
> > On 09/01/2014 11:29 AM, Arnd Bergmann wrote:
> > > On Monday 01 September 2014 23:05:59 Hanjun Guo wrote:
> > >> This patch set is example of the sort of driver changes needed to boot
> > >> Juno using ACPI tables, which using the ACPI tables devloped for MS
> > >> Windows and published by ARM [1].
> > > 
> > > What about platform support?
> > 
> > I think Juno is just serving as an example here since it's from ARM and
> > thus various people have access to it already, etc. It's not the best
> > example of a server platform out there, since that wasn't its original
> > design purpose (but it's a wonderful platform nonetheless). There is
> > work currently in flight to offer other reference ACPI examples.
> 
> Ok, I see. This is a bit disappointing because it's actually the third
> attempt to come up with a reference platform (after Exynos and X-Gene),
> and it always seems to come down to deciding that this particular
> platform doesn't really work with ACPI beyond basic booting.
> 
> Which platform(s) are you talking about? Are you sure it will be better
> suited than the first three?

Juno is actually working out as a good reference platform. It works and
there aren't horrible things that need to be done to get the system into
a working state. AMD Seattle is a second system that will boot with
Hanjun's ACPI series with a couple of device driver patches (the SBSA
driver which is common with Juno and an Ethernet driver IIRC).

g.
