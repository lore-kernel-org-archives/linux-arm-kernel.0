From: bcm@fixthebug.org (Christian Daudt)
Date: Wed, 8 Jan 2014 23:52:24 -0800
Subject: [GIT PULL] bcm driver updates for 3.14
In-Reply-To: <20140109060432.GC8285@quad.lixom.net>
References: <CAEPRUYpgHhrVCoRAzF_WbQZGTpwSahQq8G40+9=pf36-n9V_hg@mail.gmail.com>
 <20140109060432.GC8285@quad.lixom.net>
Message-ID: <CAEPRUYpZTTX8bB68V5WMzBroj+arADsbbmXVSgBtn0At1SmRmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 8, 2014 at 10:04 PM, Olof Johansson <olof@lixom.net> wrote:
> On Sun, Jan 05, 2014 at 10:58:36PM -0800, Christian Daudt wrote:
>> The following changes since commit 319e2e3f63c348a9b66db4667efa73178e18b17d:
>>
>>   Linux 3.13-rc4 (2013-12-15 12:31:33 -0800)
>>
>> are available in the git repository at:
>>
>>   git://github.com/broadcom/bcm11351.git tags/bcm-for-3.14-drivers
>
> Hi,
>
> Is there a reason you're sending this through arm-soc instead of through Mike's
> clk tree? I don't see any dependencies on SoC code so I think it can go
> independently through clk?
>
>
> -Olof
The reason for the clk patches is that the file
include/dt-bindings/clock/bcm281xx.h is  used both by the driver and
the by the bcm11351.dtsi file (which has other mods going through
arm-soc). But now that you mentioned it, I looked and didn't find the
patch that modifies dts to include it. Alex - did I miss it?

 thanks,
   csd
