From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Tue, 31 Jan 2017 09:16:35 +0100
Subject: [GIT PULL] STM32 DT changes for v4.11 #1 V2
In-Reply-To: <20170131050435.GA16560@localhost>
References: <a8f6b0aa-412e-65b7-5d88-e4b17097c3a8@st.com>
 <20170131050435.GA16560@localhost>
Message-ID: <1b1ef752-71d2-3e36-d851-bc299e404111@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof

On 01/31/2017 06:04 AM, Olof Johansson wrote:
> On Fri, Jan 20, 2017 at 03:40:41PM +0100, Alexandre Torgue wrote:
>> Hi Olof, Arnd and Kevin,
>>
>> Please consider this second version of first round of STM32 DT updates for
>> v4.11:
>>
>> The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:
>>
>>   Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git
>> tags/stm32-dt-for-v4.11-1-v2
>>
>> for you to fetch changes up to a4e6964a78946bf3ce969d9fef5f201e0236f0ea:
>>
>>   ARM: dts: stm32: enable RTC on stm32429i-eval (2017-01-20 14:59:58 +0100)
>>
>> ----------------------------------------------------------------
>> STM32 DT updates for v4.11, round 1 Version 2.
>>
>> Highlights:
>> ----------
>>
>>  - ADD RTC support on STM32F429 MCU
>>  - Enable RTC on STM32F469and STM32F429 boards
>>  - ADD ADC support on STM32F429 MCU
>>  - Enable ADC on STM32F429 Eval board
>>  - Add I2S external clock
>>  - Fix memory size for STM32F429 Disco
>>
>> Note:
>> -----
>> First patch "clk: stm32f4: Update DT bindings documentation")
>> has already been merged in clock tree. Compare to version 1
>> git merge has been used to take this patch.
>
> Merged, thanks! Sorry for this taking a while.
>
No pb, thanks!

I think, It's a bit late to send a second round. Isn't ?

>
> Oh, minor comment: For next time, the note doesn't have to go in the tag
> description, just the pull request.

sure.

Regards
Alex
>
>
>
> -Olof
>
