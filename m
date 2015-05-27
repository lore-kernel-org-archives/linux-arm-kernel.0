From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Wed, 27 May 2015 15:40:52 +0100
Subject: [PATCH 1/2 v2] ARM64: juno: add GPIO keys
In-Reply-To: <CACRpkdbm9LxaWQa=SQAhOKYVncPoFiKv_M6cN1oUEqctiR5=pQ@mail.gmail.com>
References: <1432629650-19559-1-git-send-email-linus.walleij@linaro.org>
 <20150526093734.GB2175@e106497-lin.cambridge.arm.com>
 <CACRpkdbm9LxaWQa=SQAhOKYVncPoFiKv_M6cN1oUEqctiR5=pQ@mail.gmail.com>
Message-ID: <20150527144052.GF2175@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 27, 2015 at 01:42:58PM +0100, Linus Walleij wrote:
> On Tue, May 26, 2015 at 11:37 AM, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> 
> > I'm going to do a test on my board once I find a bit of spare time
> > as I have some in-house reports that the handling of the GPIO
> > buttons is not reliable and on some boards it led to board reset.
> > Firmware might have been updated since (last year) so it would be
> > useful if you can tell me the version(s) of firmware that you are
> > using.
> 
> ARM V2M-Juno Boot loader v1.0.0
> HBI0262 build 616
> 
> ARM V2M_Juno Firmware v1.1.8
> Build Date: Jun 17 2014
> 
> Time :  12:23:19
> Date :  27:05:2015
> 
> Cmd> reboot
> 
> This?

Also useful if you can capture the text printed by BL1 when booting (depending
on which version you have there might not be much).

NOTICE:  Booting Trusted Firmware
NOTICE:  BL1: v1.0(release):a3a41cc
NOTICE:  BL1: Built : 16:15:48, Jan 23 2015
NOTICE:  BL1: Booting BL2
NOTICE:  BL2: v1.0(release):1c73ffb
NOTICE:  BL2: Built : 15:19:28, Jan 26 2015
NOTICE:  BL1: Booting BL3-1
NOTICE:  BL3-1: v1.0(release):1c73ffb
NOTICE:  BL3-1: Built : 15:19:30, Jan 26 2015
UEFI firmware (version a4c2dfb284a55e73f34c48f5944a438006384f04 built at 17:44:48 on Jan 13 2015)

Best regards,
Liviu

> 
> Yours,
> Linus Walleij
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
