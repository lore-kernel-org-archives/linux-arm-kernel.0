From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 20 Nov 2012 13:37:17 +0530
Subject: [GIT PULL 4/6] DaVinci DT updates for v3.8
In-Reply-To: <20121120062816.GA11997@quad.lixom.net>
References: <1351620701-16516-1-git-send-email-nsekhar@ti.com>
 <1351620701-16516-4-git-send-email-nsekhar@ti.com>
 <20121120062816.GA11997@quad.lixom.net>
Message-ID: <50AB3A35.8070208@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/20/2012 11:58 AM, Olof Johansson wrote:
> Hi,
> 
> On Tue, Oct 30, 2012 at 11:41:39PM +0530, Sekhar Nori wrote:
>> The following changes since commit 8e0d72d2c7a6955692ba0a21bbf5ca86e8061777:
>>
>>   ARM: davinci: da8xx: add DA850 PRUSS support (2012-10-27 16:28:36 +0530)
>>
>> are available in the git repository at:
>>
>>   git://gitorious.org/linux-davinci/linux-davinci.git tags/davinci-for-v3.8/dt
>>
>> for you to fetch changes up to 3a373904b88a73445f7a78249cf60efabbf1a9f3:
>>
>>   ARM: davinci: da850: generate dtbs for da850 boards (2012-10-29 15:44:26 +0530)
>>
>> ----------------------------------------------------------------
>> These changes add DT boot support to DaVinci DA850
>> SoC.
>>
>> ----------------------------------------------------------------
>> Heiko Schocher (2):
>>       ARM: davinci: da850: add SoC DT data
>>       ARM: davinci: add support for am1808 based EnBW CMC board
>>
>> Sekhar Nori (3):
>>       ARM: davinci: da850: add DT boot support
>>       ARM: davinci: da850 evm: add DT data
>>       ARM: davinci: da850: generate dtbs for da850 boards
> 
> The dtb targets now live in arch/arm/boot/dts/Makefile, they were moved there
> for 3.7. I've applied a local patch in arm-soc (next/dt) on top of this branch
> that moves them over.

Thanks for fixing it up.

Regards,
Sekhar
