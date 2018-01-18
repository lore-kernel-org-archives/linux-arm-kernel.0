From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 18 Jan 2018 08:03:37 +0100 (CET)
Subject: mmc1 timeout issue with rpi3
In-Reply-To: <b094ab76-8a4e-b47b-4266-4c401f62b8ce@orpaltech.com>
References: <5d800b63-d45d-d4e4-214c-3ebf602c79e9@orpaltech.com>
 <1059643032.72553.1516136078614@email.1und1.de>
 <5ab12aa4-57a9-55b5-ef43-43b2eac9c1b7@orpaltech.com>
 <1199109167.10232.1516213158515@email.1und1.de>
 <665b39ed-e42e-4bd5-36ba-65e733089537@orpaltech.com>
 <998321576.11526.1516217542223@email.1und1.de>
 <b094ab76-8a4e-b47b-4266-4c401f62b8ce@orpaltech.com>
Message-ID: <974305384.15547.1516259017873@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergey,

> Sergey Suloev <ssuloev@orpaltech.com> hat am 17. Januar 2018 um 21:04 geschrieben:
> 
> 
> Hi Stefan,
> 
> On 01/17/2018 10:32 PM, Stefan Wahren wrote:
> > Hi Sergey,
> >
> >> Sergey Suloev <ssuloev@orpaltech.com> hat am 17. Januar 2018 um 19:49 geschrieben:
> >>
> >>
> >> Hi Stefan
> >>
> >> wifi network was working fine when I used a raspbian image downloaded
> >> from official site.
> >>
> >> Here is my config https://pastebin.com/7XRpmM0X  and cpuinfo
> >> https://pastebin.com/08Z6gDZ9
> >>
> >> I have no idea about version you are talking about.
> > please stop top-posting.
> >
> > I was talking about the board revision of your RPi. You can get this information by looking at the PCB.
> >
> > I updated to the last firmware and your config but i'm unable to reproduce this issue.
> >
> > Do you use U-Boot or only the Raspberry Pi bootloader?
> > What are your modifications to config.txt?
> >
> >> Thanks.
> >>
> >>
> I am using u-boot tagged 2018.01.

interesting. I don't use u-boot as second stage bootloader. Maybe it messed up the pin configuration of the GPIO expander. Could you please try without u-boot?
