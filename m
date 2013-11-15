From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Nov 2013 21:19:55 +0100
Subject: [PATCH 1/3] Documentation: Add APM X-Gene SoC 6.0Gbps SATA PHY
 driver binding documentation
In-Reply-To: <CAPw-ZTmkP19O4jAhhPcWStEM+Cy_AtxUFPr_rhR6+6MRe_rXFQ@mail.gmail.com>
References: <1384457519-21335-1-git-send-email-lho@apm.com>
 <201311152054.10859.arnd@arndb.de>
 <CAPw-ZTmkP19O4jAhhPcWStEM+Cy_AtxUFPr_rhR6+6MRe_rXFQ@mail.gmail.com>
Message-ID: <201311152119.55630.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 November 2013, Loc Ho wrote:
> Hi,
> 
> >> It may be possible from ACPI point of view (hasn't tried yet). But for
> >> DTS, there is no such firmware.
> >
> > Why not? Doesn't any boot loader have to initialize the hardware in order
> > to load a kernel from disk?
> [Loc Ho]
> Not necessary for network booting, SD boot, and USB boot with ramdisk.

But why not just initialize them all if you already have the boot loader
contain all the drivers? There really isn't any difference between
passing an ACPI blob or a DT blob to the kernel, as far as the boot loader
is concerned.

	Arnd
