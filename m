From: lho@apm.com (Loc Ho)
Date: Fri, 15 Nov 2013 12:52:17 -0800
Subject: [PATCH 1/3] Documentation: Add APM X-Gene SoC 6.0Gbps SATA PHY
 driver binding documentation
In-Reply-To: <201311152119.55630.arnd@arndb.de>
References: <1384457519-21335-1-git-send-email-lho@apm.com>
 <201311152054.10859.arnd@arndb.de>
 <CAPw-ZTmkP19O4jAhhPcWStEM+Cy_AtxUFPr_rhR6+6MRe_rXFQ@mail.gmail.com>
 <201311152119.55630.arnd@arndb.de>
Message-ID: <CAPw-ZTmDrxQYzMnF69TTOupy7uO94qo=3tr2X03GLpzqMusRxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

>> >> It may be possible from ACPI point of view (hasn't tried yet). But for
>> >> DTS, there is no such firmware.
>> >
>> > Why not? Doesn't any boot loader have to initialize the hardware in order
>> > to load a kernel from disk?
>> [Loc Ho]
>> Not necessary for network booting, SD boot, and USB boot with ramdisk.
>
> But why not just initialize them all if you already have the boot loader
> contain all the drivers? There really isn't any difference between
> passing an ACPI blob or a DT blob to the kernel, as far as the boot loader
> is concerned.
>
[Loc Ho]
Yes... It is a possible solution. The draw back would be slow down the
boot loader. For now, let me implement the PHY for DTS and no PHY for
ACPI. From previous emails, it was discussed that PHY driver is
required for DTS. For ACPI, it is the responsible of the firmware.

-Loc
