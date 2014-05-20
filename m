From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 21 May 2014 01:13:17 +0800
Subject: [GIT PULL] at91: DT for 3.16 #2
In-Reply-To: <20140520055041.GO18956@quad.lixom.net>
References: <1400059162-630-1-git-send-email-nicolas.ferre@atmel.com>
 <20140520055041.GO18956@quad.lixom.net>
Message-ID: <58381B35-AAB4-4FE5-833D-603052C97E9E@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On May 20, 2014, at 1:50 PM, Olof Johansson <olof@lixom.net> wrote:

> 
> On Wed, May 14, 2014 at 11:19:22AM +0200, Nicolas Ferre wrote:
>> Arnd, Olof, Kevin,
>> 
>> More DT material for AT91. Some fixes that apply on what was merged for 3.15
>> but that are not very critical.
>> The other patches are feature additions to old or very recent product/board:
>> at91sam9261 or sama5d3 Xplained.
>> 
>> Thanks, best regards,
>> 
>> The following changes since commit 27a96a0364787d2b41d2a72d08143d95263e1b07:
>> 
>>  ARM: at91: sama5d3: clock for ssc from rk pin (2014-04-18 22:43:44 +0200)
>> 
>> are available in the git repository at:
>> 
>>  git://github.com/at91linux/linux-at91.git tags/at91-dt2
>> 
>> for you to fetch changes up to a93f9c88b7701d1c4c3b22d39d64a408f000a6ef:
>> 
>>  ARM: at91/dt: at91-sama5d3_xplained: add the regulator device node (2014-05-12 16:48:54 +0200)
> 
> Merged, but:
> 
>> arch/arm/boot/dts/at91-sama5d3_xplained.dts |  62 +++++++++++++++
>> arch/arm/boot/dts/at91sam9261.dtsi          | 114 ++++++++++++++++++++++++++--
>> arch/arm/boot/dts/at91sam9rl.dtsi           |   7 +-
>> arch/arm/boot/dts/sama5d3.dtsi              |  78 +++++++++++++++++++
> 
> Grmbl. I remember being somewhat annoyed that you didn't use at91 prefix
> when you introduced the sama5d3 dtsi files, but please don't start using
> it on a random board like this, especially when other boards just use
> the sama5d3_<board>.dts format.
> 
> Care to fix this up in time for 3.16 merge window?

there is a small issue here Atmel drop the at91 in the soc name

Best Regards,
J.
> 
> 
> Thanks,
> 
> -Olof
