From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 Jun 2012 15:24:26 +0000
Subject: [PATCH v2] arm: Add basic support for new Marvell Armada 370 and
 Armada XP SoC
In-Reply-To: <4FD8AC5E.1060804@redhat.com>
References: <1339433585-28087-1-git-send-email-gregory.clement@free-electrons.com>
 <4FD8AC5E.1060804@redhat.com>
Message-ID: <201206131524.26653.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 June 2012, Jon Masters wrote:
> On 06/11/2012 12:52 PM, Gregory CLEMENT wrote:
> 
> > You'll find in this patch set the new version of the initial support for a
> > new family of ARMv7-compatible Marvell SoCs initially submitted by my
> > colleague Thomas Petazzoni. Following the conclusion of the discussion when
> > we submitted our first version we have chosen to add this support for this
> > SoC family in the to support in the arch/arm/mach-mvebu/ directory.
> 
> Pardon my silly question. I know that there's an effort to reconcile the
> two different SoCs so you're picking a neutral name, but what does
> "mvebu" mean, and will you be persistently keeping this name? Our guys
> want to know what this new platform will entail for Fedora support in
> terms of the platform name being used in various non-kernel places.

We've had an extended discussion about the name when the patches
were posted for the first time. It was just the best thing that anyone
suggested so far given the alternatives.

"EBU" is the business unit that makes all the SoCs in this family
(orion, kirkwood, armadaxp, dove, ...) and no other name that was
suggested covers all of these but not also at least some of the other
Marvell SoCs (pxa, mmp, armada1000, ...).

Just "ebu" would not be very clear, and other variations (mv-ebu,
mrvl-ebu) were considered to be too long.

	Arnd
