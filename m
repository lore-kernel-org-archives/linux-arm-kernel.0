From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 19 Jan 2017 09:20:55 +0530
Subject: [GIT PULL] DaVinci fix for v4.10
In-Reply-To: <20170119001242.GB23725@localhost>
References: <214ce380-3c45-423c-a7bc-e19ea1ce2a2d@ti.com>
 <20170119001242.GB23725@localhost>
Message-ID: <dd59ae9d-e224-7fd0-bcaf-856ca1b10b94@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Thursday 19 January 2017 05:42 AM, Olof Johansson wrote:
> Hi Sekhar,
> 
> On Wed, Jan 18, 2017 at 04:23:55PM +0530, Sekhar Nori wrote:
>> The following changes since commit 49def1853334396f948dcb4cedb9347abb318df5:
>>
>>   Linux 4.10-rc4 (2017-01-15 16:21:59 -0800)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-fixes-for-v4.10-part2
>>
>> for you to fetch changes up to 6f042ee9cc09792c1c0f0cd8f275c2b4b29eaa96:
>>
>>   ARM: dts: da850-evm: fix read access to SPI flash (2017-01-18 15:38:08 +0530)
>>
>> ----------------------------------------------------------------
>> This patch uses fast-read opcode to read the
>> SPI flash. This is needed for error-free read
>> at 30Mhz.
>>
>> ----------------------------------------------------------------
>> Fabien Parent (1):
>>       ARM: dts: da850-evm: fix read access to SPI flash
> 
> You're ahead of our branch since this is based on -rc4 when it doesn't
> have to. Want to respin, or should I cherry-pick the patch?

Cherry-picking is fine. Thanks!

Regards,
Sekhar
