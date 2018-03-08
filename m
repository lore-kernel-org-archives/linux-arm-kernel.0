From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Thu, 8 Mar 2018 13:55:34 +0100
Subject: [GIT PULL] STM32 SOC changes for v4.17 #1
In-Reply-To: <CAK8P3a0w4Wj7fyqrt5XTCO6G7_qg3fQzeO6eCRLoSDQs6H2QKA@mail.gmail.com>
References: <d283d515-5f73-2207-9ed7-d554ddb673ae@st.com>
 <CAK8P3a0w4Wj7fyqrt5XTCO6G7_qg3fQzeO6eCRLoSDQs6H2QKA@mail.gmail.com>
Message-ID: <aac3c738-784d-fb0e-5189-4e09c8e5dae9@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd

On 03/07/2018 04:12 PM, Arnd Bergmann wrote:
> On Mon, Mar 5, 2018 at 12:15 PM, Alexandre Torgue
> <alexandre.torgue@st.com> wrote:
>> Hi Arnd, Olof and Kevin,
>>
>> Please consider this first round of STM32 SOC updates for v4.17:
>>
>> The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:
>>
>>    Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)
>>
>> are available in the git repository at:
>>
>>    git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git
>> tags/stm32-soc-for-v4.17-1
>>
>> for you to fetch changes up to 2092e3adc323695255bd06d65f14c89afb5727ae:
>>
>>    ARM: stm32: restore reboot capabilities (2018-03-05 09:11:58 +0100)
>>
>> ----------------------------------------------------------------
>> STM32 SOC updates for v4.17, round 1.
>>
>> Highlights:
>> ----------
>>   -Add STM32F769 MCU support
>>   -Add STM32MP157 MPU support
>>   -Add AMBA PL180 MMCI support for F4 and F7 MCUs
>>   -Move STM32 documentation to rst format
> 
> It would have been good to get a little more explanation about what the various
> added chips are, since I try to distill the information into my own changelogs
> for the pull request to Linus.
> 
> The added documentation files contain all the information of course,
> so I'll use that.

Noted for next time.

Thanks
Alex

> 
>          Arnd
> 
