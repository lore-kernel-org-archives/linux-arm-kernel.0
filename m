From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 06 Jan 2015 15:11:25 +0100
Subject: [PATCH 0/4] suport for Alphascale ASM9260, part 4
In-Reply-To: <54ABC1BC.6020801@rempel-privat.de>
References: <201411281509.19170.arnd@arndb.de>
 <1417193657-31602-1-git-send-email-linux@rempel-privat.de>
 <54ABC1BC.6020801@rempel-privat.de>
Message-ID: <1733388.SP14pjVoMj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 06 January 2015 12:06:36 Oleksij Rempel wrote:
> Hello all,
> 
> any updates here?
> 
> Am 28.11.2014 um 17:54 schrieb Oleksij Rempel:
> > Oleksij Rempel (4):
> >   ARM: clocksource: add asm9260_timer driver
> >   ARM: dts: add DT for Alphascale ASM9260 SoC
> >   ARM: add alphascale,acc.txt bindings documentation
> >   add Alphascale to vendor-prefixes.txt
> > 
> 

I think this fell through the cracks because you were not
very explicit about what you expected to happen with the patches.

Please submit the parts that are missing to the respective
maintainers again. The clocksource driver should get sent
as a standalone patch to the addresses listed in the MAINTAINERS
file, the rest should be addressed to arm at kernel.org with
an introductory message asking for merging.

I usually do some sweeps through my inbox looking for anything
with [GIT PULL] in the subject, or mails that got sent to
arm at kernel.org, but this one was neither.

If we miss some patches that you think should have been merged
already, it also helps to send a reminder about it.

	Arnd
