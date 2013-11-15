From: lho@apm.com (Loc Ho)
Date: Fri, 15 Nov 2013 12:00:17 -0800
Subject: [PATCH 1/3] Documentation: Add APM X-Gene SoC 6.0Gbps SATA PHY
 driver binding documentation
In-Reply-To: <201311152054.10859.arnd@arndb.de>
References: <1384457519-21335-1-git-send-email-lho@apm.com>
 <201311152026.07433.arnd@arndb.de>
 <CAPw-ZTnyknFs2S5uZOH7RyAqcQrk7z=Ms0QfRGd-kQfYsw4+wQ@mail.gmail.com>
 <201311152054.10859.arnd@arndb.de>
Message-ID: <CAPw-ZTmkP19O4jAhhPcWStEM+Cy_AtxUFPr_rhR6+6MRe_rXFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

>> It may be possible from ACPI point of view (hasn't tried yet). But for
>> DTS, there is no such firmware.
>
> Why not? Doesn't any boot loader have to initialize the hardware in order
> to load a kernel from disk?
[Loc Ho]
Not necessary for network booting, SD boot, and USB boot with ramdisk.

-Loc
