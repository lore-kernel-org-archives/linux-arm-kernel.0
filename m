From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Fri, 5 Jan 2018 07:55:04 +0100
Subject: [GIT PULL] arm: actions: dt for v4.16 #1
In-Reply-To: <20180105063729.ttkwbct2smxx5x3z@localhost>
References: <20171222102107.5661-1-afaerber@suse.de>
 <20180105063729.ttkwbct2smxx5x3z@localhost>
Message-ID: <74085346-811d-63ff-67a5-ac0ef12b1985@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 05.01.2018 um 07:37 schrieb Olof Johansson:
> On Fri, Dec 22, 2017 at 11:21:05AM +0100, Andreas F?rber wrote:
>> Hi Olof and Arnd,
>>
>> Here's my dt pull for Actions Semi.
>> This adds one new S500 based board, which I already updated to new SPDX style.
>> A second pull will follow after I've converted the existing boards.
>>
>> Regards,
>> Andreas
>>
>> The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:
>>
>>   Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions.git tags/actions-arm-dt-for-4.16
>>
>> for you to fetch changes up to 271a70da383cf69f32742d9e2d01a7b16d04d60c:
>>
>>   arm: dts: owl-s500: Add Sparky (2017-12-22 10:53:52 +0100)
>>
>> ----------------------------------------------------------------
>> Actions Semi arm based SoC DT for v4.16
>>
>> This adds a DT for the Allo.com Sparky SBC.
>>
>> ----------------------------------------------------------------
>> Andreas F?rber (3):
>>       dt-bindings: Add vendor prefix for Allo.com
>>       dt-bindings: arm: actions: Add Sparky
>>       arm: dts: owl-s500: Add Sparky
> 
> Merged.

Thanks!

> Tiny nit: For 32-bit, we use ARM: as prefix (and arm64: for 64-bit).
> Yes, it's confusing. :)

It's not confusing, it's just that Arm switched from ARM to arm/Arm, so
I started adjusting my scripts. I can revert that of course.

Cheers,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
