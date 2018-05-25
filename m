From: xuwei5@hisilicon.com (Wei Xu)
Date: Fri, 25 May 2018 17:18:06 +0100
Subject: [GIT PULL v2] arm64: defconfig: hisilicon config updates for v4.18
In-Reply-To: <20180525120140.d5gtksg62xlr6cz3@localhost>
References: <5AFEB1E0.9030200@hisilicon.com>
 <20180525120140.d5gtksg62xlr6cz3@localhost>
Message-ID: <5B08373E.8080303@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On 2018/5/25 13:01, Olof Johansson wrote:
> On Fri, May 18, 2018 at 11:58:40AM +0100, Wei Xu wrote:
>> Hi Olof, Hi Arnd,
>>
>> Please help to pull the following changes.
>> Thanks!
>>
>> Best Regards,
>> Wei
>>
>> ---
>>
>> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
>>
>>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
>>
>> are available in the Git repository at:
>>
>>   git://github.com/hisilicon/linux-hisi.git tags/hisi-defconfig-for-4.18v2
>>
>> for you to fetch changes up to 9ab1c973324566baa314f8dd4e3827e4076a8675:
>>
>>   arm64: defconfig: Enable HISILICON_LPC (2018-05-11 11:39:01 +0100)
>>
>> ----------------------------------------------------------------
>> ARM64: hisilicon: defconfig updates for 4.18
>>
>> - Sync the arm64 defconfig with savedefconfig
>> - Enable the support of ethernet, eMMC, Combo/INNO phy
>>   and PCIe for Hi3798CV200
>> - Enable the LPC for hip06 and hip07
>>
>> ----------------------------------------------------------------
>> John Garry (1):
>>       arm64: defconfig: Enable HISILICON_LPC
>>
>> Shawn Guo (2):
>>       arm64: defconfig: sync it with savedefconfig
> 
> Same feedback here as for  Gregory on his Marvell pull request -- please don't
> run savedefconfig since it messes up and adds a lot of conflicts for everybody.
> We'll do it in our tree right around the end of the merge window instead.

Got it.

> 
> It's probably easiest to send the patches as patches so we can fix them up if
> needed, so please resend separately and we'll apply. (Or send a new pull
> request with just the two new config changes).

I will send a new pull request with the new config changes.
Thanks!

Best Regards,
Wei

> 
> Thanks!
> 
> 
> -Olof
> 
> .
> 
