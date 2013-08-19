From: khilman@linaro.org (Kevin Hilman)
Date: Mon, 19 Aug 2013 09:32:45 -0700
Subject: [GIT PULL] DaVinci fixes for v3.11
In-Reply-To: <5211CC26.7050702@ti.com> (Sekhar Nori's message of "Mon, 19 Aug
 2013 13:11:26 +0530")
References: <5211C957.4090902@ti.com> <5211CC26.7050702@ti.com>
Message-ID: <87mwodk5ea.fsf@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sekhar,

Sekhar Nori <nsekhar@ti.com> writes:

>> The following changes since commit d4e4ab86bcba5a72779c43dc1459f71fea3d89c8:
>> 
>>   Linux 3.11-rc5 (2013-08-11 18:04:20 -0700)
>> 
>> are available in the git repository at:
>> 
>>   git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-fixes-for-v3.11
>> 
>> for you to fetch changes up to de30e316d38b0837fe4c09b43f1b52c8e230c44e:
>> 
>>   ARM: davinci: nand: specify ecc strength (2013-08-16 15:12:20 +0530)
>> 
>> ----------------------------------------------------------------
>> This pull request includes a patch for
>> making NAND flash work on multiple DaVinci
>> boards. The NAND probe was failing because
>> ecc strength was not specified while using
>> hardware ecc algorithm.

Note that our current fixes branch is based on -rc4, and since it
doesn't look like this fix is in -next, I've rebased it onto our fixes
branch.

IOW, rebased to -rc4, and applied to fixes.

In general, we prefer fixes based on older -rcs (at least not newer than
the current fixes branch) unless there is a dependency on a newer -rc.

Thanks,

Kevin
