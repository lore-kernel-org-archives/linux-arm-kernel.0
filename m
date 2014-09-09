From: jcm@redhat.com (Jon Masters)
Date: Tue, 9 Sep 2014 10:13:01 -0400 (EDT)
Subject: [RFC PATCH for Juno 0/2] Drivers for Juno to boot from ACPI
In-Reply-To: <3840839.IPB3Ru8Evk@wuerfel>
References: <1409583961-7466-1-git-send-email-hanjun.guo@linaro.org>
 <353732273.2TKdyNJ83M@wuerfel> <540EA446.7010200@redhat.com>
 <3840839.IPB3Ru8Evk@wuerfel>
Message-ID: <507704665.9032709.1410271981816.JavaMail.zimbra@zmail15.collab.prod.int.phx2.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I expect you will see followup email from a vendor in a few hours.

-- 
Computer Architect | Sent from my #ARM Powered Mobile device

On Sep 9, 2014 6:56 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tuesday 09 September 2014 02:55:02 Jon Masters wrote: 
> > On 09/01/2014 11:On Tuesday 09 September 2014 02:55:02 Jon Masters wrote:
> On 09/01/2014 11:29 AM, Arnd Bergmann wrote:
> > On Monday 01 September 2014 23:05:59 Hanjun Guo wrote:
> >> This patch set is example of the sort of driver changes needed to boot
> >> Juno using ACPI tables, which using the ACPI tables devloped for MS
> >> Windows and published by ARM [1].
> > 
> > What about platform support?
> 
> I think Juno is just serving as an example here since it's from ARM and
> thus various people have access to it already, etc. It's not the best
> example of a server platform out there, since that wasn't its original
> design purpose (but it's a wonderful platform nonetheless). There is
> work currently in flight to offer other reference ACPI examples.

Ok, I see. This is a bit disappointing because it's actually the third
attempt to come up with a reference platform (after Exynos and X-Gene),
and it always seems to come down to deciding that this particular
platform doesn't really work with ACPI beyond basic booting.

Which platform(s) are you talking about? Are you sure it will be better
suited than the first three?

	Arnd
