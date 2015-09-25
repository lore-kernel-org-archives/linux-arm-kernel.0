From: robertcnelson@gmail.com (Robert Nelson)
Date: Fri, 25 Sep 2015 11:23:50 -0500
Subject: [PATCH] ARM: dts: Add am335x-bonegreen
In-Reply-To: <CAOCHtYhuLREw_eKbME+Ssvx=JrHWtbFZPQRH5SrmfVTiSqdtWQ@mail.gmail.com>
References: <1443193831-5693-1-git-send-email-robertcnelson@gmail.com>
 <5605704D.5000404@ti.com>
 <CAOCHtYhuLREw_eKbME+Ssvx=JrHWtbFZPQRH5SrmfVTiSqdtWQ@mail.gmail.com>
Message-ID: <CAOCHtYhf1yvQcB073VvT1JKmut7M7cdL9a7Ms42AxyuOOWj6-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>
>> Would still work when https://patchwork.kernel.org/patch/6394821/ gets in?
>
> That will still work, but we need to extend the board identification
> to "board-name" + "board-revision", as the Green choose the "A335BNLT"
> board name in the eeprom to remain compatible with older 3.8.x images
> from last year.. (most of the clones i've talked too want to support
> the old image too)...
>
> So with the 1st byte of the board-revision:
> All BeagleBone Black's have: 0x30
> Seeed's using 0x1A (with the potential to increment the A)

I should add, we have an official-ish list at the top of (1), to help
keep track of this...

1: https://github.com/beagleboard/image-builder/blob/master/readme.md

Regards,

-- 
Robert Nelson
https://rcn-ee.com/
