From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 7 Aug 2016 10:09:12 +0200 (CEST)
Subject: [PATCH RFC 2/3] mmc: core: add new cap for 3.3V only DDR MMCs
In-Reply-To: <7284d9a4-164d-dd2d-b9a0-dd1de6c76274@rock-chips.com>
References: <1470488140-10104-1-git-send-email-stefan.wahren@i2se.com>
 <1470488140-10104-3-git-send-email-stefan.wahren@i2se.com>
 <0e38d62a-b3d0-30ca-fca9-bb740ae54d0a@denx.de>
 <16443443.114784.752d0f22-93a7-46e8-bb14-c884787aaea3.open-xchange@email.1und1.de>
 <7284d9a4-164d-dd2d-b9a0-dd1de6c76274@rock-chips.com>
Message-ID: <520205570.103061.350ab33c-8282-4c97-82e2-90a06202b849.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

> Shawn Lin <shawn.lin@rock-chips.com> hat am 7. August 2016 um 04:07
> geschrieben:
> 
> 
> ? 2016/8/6 22:18, Stefan Wahren ??:
> > Hi Marek,
> >
> >> Marek Vasut <marex@denx.de> hat am 6. August 2016 um 15:14 geschrieben:
> >>
> >>
> >> On 08/06/2016 02:55 PM, Stefan Wahren wrote:
> >>> This patch based on the work of Fabio Estevam:
> >>> "[PATCH v2] mmc: core: Do not set mmc voltage to 1.8V when
> >>> 'no-1-8-v' is present"
> >>>
> >>> It adds the support for 3.3V only DDR MMC hosts.
> >>
> >> Do such cards even exist ? Do you have a link where I can find some ?
> >
> > i never said anything about SD cards. I mean eMMC modules which usually have
> > 8
> > data pins like this one [1].
> >
> > Please don't blame me if it's not compatible to i.MX28. It's only an
> > example.
> >
> > [1] -
> > http://datasheet.octopart.com/THGBM3G4D1FBAIGH2H-Toshiba-datasheet-20748880.pdf
> 
> 
> I download the datasheet you mentioned, and I explicitly see it
> describe 1V8 everywhere, especially for the section of "ELECTRICAL
> CHARACTERISTICS".
> 
> I never see one eMMC claiming DDR52 capability but doesn't support 1V8
> so far. Could you kindly share me the part number of the eMMC you are
> using? :)

sorry the subject line is misleading. The capability flag is about the host not
about the MMC itself. There are hosts which doesn't support 1.8V. I will clarify
this in the next version.
