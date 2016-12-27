From: robertcnelson@gmail.com (Robert Nelson)
Date: Tue, 27 Dec 2016 12:01:05 -0600
Subject: [PATCH 2/4] ARM: dts: Add am335x-boneblack-wireless
In-Reply-To: <20161227175837.28970-2-robertcnelson@gmail.com>
References: <20161227175837.28970-1-robertcnelson@gmail.com>
 <20161227175837.28970-2-robertcnelson@gmail.com>
Message-ID: <CAOCHtYjx+KD3iy1cssjCLN0xjXBGJFZ_e1Qw2zRGbV4=X0+bHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 27, 2016 at 11:58 AM, Robert Nelson <robertcnelson@gmail.com> wrote:
> BeagleBone Black Wireless is clone of the BeagleBone Black (BBB) with the Ethernet
> replaced by a TI wl1835 wireless module.
>
> This board can be indentified by the BWAx value after A335BNLT (BBB) in the at24 eeprom:
> BWAx [aa 55 33 ee 41 33 33 35  42 4e 4c 54 42 57 41 35  |.U3.A335BNLTBWA5|]
>
> http://beagleboard.org/black-wireless
> https://github.com/beagleboard/beaglebone-black-wireless
>
> firmware: https://github.com/beagleboard/beaglebone-black-wireless/tree/master/firmware

Tony, this firmware should be there shortly, i have a pull request
setup for Jason:

https://github.com/beagleboard/beaglebone-black-wireless/pull/5

Regards,

-- 
Robert Nelson
https://rcn-ee.com/
