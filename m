From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Nov 2013 20:54:10 +0100
Subject: [PATCH 1/3] Documentation: Add APM X-Gene SoC 6.0Gbps SATA PHY
 driver binding documentation
In-Reply-To: <CAPw-ZTnyknFs2S5uZOH7RyAqcQrk7z=Ms0QfRGd-kQfYsw4+wQ@mail.gmail.com>
References: <1384457519-21335-1-git-send-email-lho@apm.com>
 <201311152026.07433.arnd@arndb.de>
 <CAPw-ZTnyknFs2S5uZOH7RyAqcQrk7z=Ms0QfRGd-kQfYsw4+wQ@mail.gmail.com>
Message-ID: <201311152054.10859.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 November 2013, Loc Ho wrote:
> It may be possible from ACPI point of view (hasn't tried yet). But for
> DTS, there is no such firmware.

Why not? Doesn't any boot loader have to initialize the hardware in order
to load a kernel from disk?

> I will make the entry more friendly
> for DTS. For ACPI, I am thinking that the BIOS/Firmware will just
> initialize it. As long as the clock isn't reset, the value will be
> there. Let's agree on these:
> 
> 1. DTS - use more friendly name
> 2. ACPI - handled by the BIOS/Firmware

Make sense.

	Arnd
