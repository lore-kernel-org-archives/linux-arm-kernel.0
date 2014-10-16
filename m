From: olof@lixom.net (Olof Johansson)
Date: Thu, 16 Oct 2014 10:52:25 -0700
Subject: [GIT PULL] qcom SoC changes for v3.18
In-Reply-To: <4AF7ABD3-EC90-47B8-96F3-B0AC396C52CC@codeaurora.org>
References: <A246CCDC-948C-429E-9FC5-934D317EB9D4@codeaurora.org>
 <201410011641.44037.arnd@arndb.de>
 <4AF7ABD3-EC90-47B8-96F3-B0AC396C52CC@codeaurora.org>
Message-ID: <CAOesGMgqJrpV_i4f82_eWDLCnOONipCu4fLJ-5n-T56N=8KXWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Oct 15, 2014 at 1:18 AM, Kumar Gala <galak@codeaurora.org> wrote:
>
> On Oct 1, 2014, at 4:41 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>
>> On Monday 22 September 2014, Kumar Gala wrote:
>>> The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:
>>>
>>>  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)
>>>
>>> are available in the git repository at:
>>>
>>>  git://git.kernel.org/pub/scm/linux/kernel/git/galak/linux-qcom.git tags/qcom-soc-for-3.18
>>>
>>> for you to fetch changes up to 525fbb55947177cdae507b0d292f43c2c9a75a47:
>>>
>>>  ARM: qcom: Move scm-boot files to drivers/soc and include/soc (2014-09-18 18:14:01 -0500)
>>>
>>> ----------------------------------------------------------------
>>> Qualcomm ARM Based SoC Updates for v3.18
>>>
>>> * Moved scm support into drivers/soc/qcom (allows for use by drivers)
>>> * Various bug fixes and minor feature additions to scm code
>>> * Added big-endian support to debug MSM uart
>>
>> Pulled it into next/late now. This means we're not sending it together with the
>> other pull requests to Linus. We'll see how things go during the first week
>> and may or may not send it in the second week of the merge window depending
>> on that.
>>
>>       Arnd
>
> Any update if you guys will end up sending this to linus for 3.18 or not?

There ended up being several issues with the next/late branch so I
believe the current outlook is that we'll not send it.

(Arnd has been handling most of the 3.18 stuff and he might have
changed his mind since we last talked about it, but that's the state
as far as i know).


-Olof
