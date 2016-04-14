From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 14 Apr 2016 08:54:40 +0200
Subject: [PATCH 0/3] ARM: OXNAS pull request for 4.7
In-Reply-To: <20160413175404.GF19945@localhost>
References: <1459521689-13962-1-git-send-email-narmstrong@baylibre.com>
 <20160413175404.GF19945@localhost>
Message-ID: <570F3EB0.50509@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/13/2016 07:54 PM, Olof Johansson wrote:
> On Fri, Apr 01, 2016 at 04:41:29PM +0200, Neil Armstrong wrote:
>> This is the ARM pull request for the OXNAS platform.
>> It also includes one-line change into irq-versatile-fpga.
>>
>> The following changes since commit 1e6d88ccf41c7ef2d6c99aa5e7fb9215aa0e5423:
>>
>>   Merge tag 'nios2-v4.6-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/lftan/nios2 (2016-03-30 20:40:42 -0500)
>>
>> are available in the git repository at:
>>
>>   https://github.com/superna9999/linux.git tags/ox810se-arm
>>
>> for you to fetch changes up to b4f122cdd148696e0d8c5f815ac48c5b9ed9de3f:
>>
>>   MAINTAINERS: add maintainer entry for ARM/OXNAS platform (2016-04-01 15:51:54 +0200)
>>
>> ----------------------------------------------------------------
>> ARM: Add OXNAS Platform Support
>>
>> Changes since original v3 patchset :
>> - Get rid of PLX Technology
>>
>> v3 patchset : http://lkml.kernel.org/r/1458838215-23314-1-git-send-email-narmstrong at baylibre.com

Hi Olof,
> Hi Neil,
> 
> This branch seems to start from an arbitrary point and not an -rc. We want
> branches only starting at -rc releases, please.
OK, I wasn't aware of this point, I'll send back from an -rc release.

> 
> For a new platform like this, while patch volume is low, it might be easier to
> just submit patches that we apply directly.
Sure, Arnd asked me to submit a pull request instead.

> 
> Some further questions: We usually try to add mach directories per vendor so we
> don't get large number of them. Would it make sense to call it something else
> than OxNAS here? I saw some patches posted referring to PLX instead of Oxford
> Semi as well. What's up with that?
This is a rather complex situation, OxNas is the SoC family, and AFAIK only two SoCs
from Oxford Semiconductor, which was bought by Avago which is now Broadcom, are only
in well known NAS products and sticks (OX810 and OX820).
Here OxNas makes far more sense than Oxsemi, and matches the other drivers with the
oxnas naming.

> 
> There's an overall lack of documentation of the platform in the initial patches
> as well. An overview of it, maybe with links to product information, etc, is
> useful.

Do you mean in the oxnas platform bindings ?

> 
> 
> -Olof
> 

Thanks,
Neil
