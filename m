From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 19 Dec 2013 19:41:57 -0500
Subject: [GIT PULL 2/3] ARM: keystone: SOC updates for 3.14
In-Reply-To: <87sitoighp.fsf@linaro.org>
References: <1387230397-14338-1-git-send-email-santosh.shilimkar@ti.com>
 <1387230397-14338-2-git-send-email-santosh.shilimkar@ti.com>
 <87sitoighp.fsf@linaro.org>
Message-ID: <52B39255.9010307@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 19 December 2013 06:10 PM, Kevin Hilman wrote:
> Hi Santosh,
> 
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> 
>> Arnd, Olof, Kevin,
>>
>> Please pull below keystone SOC updates for 3.14
>>
>> Regards,
>> Santosh
>>
>> The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:
>>
>>   Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git for_3.14/soc
>>
>> for you to fetch changes up to 8aad10f656470369b5802da422f68d4d31fcb865:
>>
>>   ARM: keystone: defconfig: enable USB support (2013-12-16 16:03:36 -0500)
>>
>> ----------------------------------------------------------------
> 
> Any (good) reason you're not using signed tags?
>
No reason but just forgot to include the tag information in pull request.
It was already tagged but missed to generate pull-request using tag.
Just in case you want to pull the tag, below is the info...

git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone-soc
 
>> Keystone SOC updates for 3.14
>>
>> - Allow keystone kernel to be build in BE mode
>> - Enabling DMA zone support
>> - Removal of double of_clk_init
>> - Enabling USB driver support in defconfig
>>
>> ----------------------------------------------------------------
> 
> Pulled into next/soc.  
> 
Thanks and sorry for not including the tag info first place.

Regards,
Santosh
