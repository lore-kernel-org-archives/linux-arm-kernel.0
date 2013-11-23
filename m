From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 23 Nov 2013 10:11:45 +0100
Subject: ACPI
In-Reply-To: <528FCEA6.1060602@jonmasters.org>
References: <F5C3F66D-C7C0-494A-8561-77E1DE0FA103@jonmasters.org>
 <528FC5C1.1080403@jonmasters.org> <528FCEA6.1060602@jonmasters.org>
Message-ID: <201311231011.45892.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 22 November 2013, Jon Masters wrote:
> The bottom line for me is that for those moving from existing
> architectures into the new world, everything else remains the same. Same
> OEM vendor tooling used to design and build systems and deliver and
> support them, same installation experience, very very boring. This is
> exactly how ARM will succeed in the market. One Platform. Very very
> boring and straightforward installation and management, and so on.

Yes, that part seems fine, but be aware that we still have to deal
with lots of other types of systems that are well outside of the scope
of such a server infrastructure: mobile, industrial, networking,
hobbyist, etc equipment. These will typically have very different
SoCs and not follow the server platform specs, but we still want them
to be as boring when you install a Linux distro on them.

I've talked in the past to people who got your message about ACPI
but not the rest and that are now struggling in a very misguided
attempt to bring ACPI to systems that are anything but boring and
that will cause real headaches for years on both developers and users
if they actually end up shipping.

	Arnd
