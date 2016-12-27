From: tony@atomide.com (Tony Lindgren)
Date: Tue, 27 Dec 2016 10:14:30 -0800
Subject: [PATCH 2/4] ARM: dts: Add am335x-boneblack-wireless
In-Reply-To: <CAOCHtYjx+KD3iy1cssjCLN0xjXBGJFZ_e1Qw2zRGbV4=X0+bHg@mail.gmail.com>
References: <20161227175837.28970-1-robertcnelson@gmail.com>
 <20161227175837.28970-2-robertcnelson@gmail.com>
 <CAOCHtYjx+KD3iy1cssjCLN0xjXBGJFZ_e1Qw2zRGbV4=X0+bHg@mail.gmail.com>
Message-ID: <20161227181429.GY4920@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Robert Nelson <robertcnelson@gmail.com> [161227 10:02]:
> On Tue, Dec 27, 2016 at 11:58 AM, Robert Nelson <robertcnelson@gmail.com> wrote:
> > BeagleBone Black Wireless is clone of the BeagleBone Black (BBB) with the Ethernet
> > replaced by a TI wl1835 wireless module.
> >
> > This board can be indentified by the BWAx value after A335BNLT (BBB) in the at24 eeprom:
> > BWAx [aa 55 33 ee 41 33 33 35  42 4e 4c 54 42 57 41 35  |.U3.A335BNLTBWA5|]
> >
> > http://beagleboard.org/black-wireless
> > https://github.com/beagleboard/beaglebone-black-wireless
> >
> > firmware: https://github.com/beagleboard/beaglebone-black-wireless/tree/master/firmware
> 
> Tony, this firmware should be there shortly, i have a pull request
> setup for Jason:
> 
> https://github.com/beagleboard/beaglebone-black-wireless/pull/5

OK great, good to have these working out of the box with mainline
kernel :)

Tony
