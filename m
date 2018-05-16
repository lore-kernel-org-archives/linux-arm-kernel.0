From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 16 May 2018 11:03:17 +0530
Subject: [GIT PULL] DaVinci fixes for v4.17 (part 2)
In-Reply-To: <20180515205043.icbkcuugupmk6kas@localhost>
References: <fcf8613b-31df-733b-3443-c1a6176cbdd1@ti.com>
 <20180515205043.icbkcuugupmk6kas@localhost>
Message-ID: <01b4188a-021c-2246-2edc-6ffebf689416@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Wednesday 16 May 2018 02:20 AM, Olof Johansson wrote:
> On Tue, May 15, 2018 at 02:52:14PM +0530, Sekhar Nori wrote:
>> The following changes since commit 9411ac07cd764be34bbd7ff09125a6b7b9175d4c:
>>
>>   ARM: davinci: fix GPIO lookup for I2C (2018-05-02 14:55:06 +0530)
>>
>> are available in the Git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-fixes-for-v4.17-part-2
>>
>> for you to fetch changes up to bb7298a7e87cf3430eb62be8746e5d7a07ca9d7c:
>>
>>   ARM: davinci: board-dm646x-evm: set VPIF capture card name (2018-05-15 14:31:12 +0530)
>>
>> ----------------------------------------------------------------
>> Second set of fixes for TI DaVinci.
>>
>> They are needed for DM6467 EVM to work. The first patch fixes an
>> issue with timer interrupt and the second two are needed for video
>> driver to probe successfully.
> 
> Merged, thanks.
> 
> Was DM6467 ever working, so is this a regression?

This is a regression, but not introduced in this release. I will
shore-up DM6467 testing to catch these earlier in future.

Thanks,
Sekhar
