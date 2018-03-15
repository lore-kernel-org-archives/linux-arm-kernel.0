From: patrice.chotard@st.com (Patrice CHOTARD)
Date: Thu, 15 Mar 2018 15:22:24 +0000
Subject: [GIT PULL] STi DT update for v4.17 round 2
In-Reply-To: <CAK8P3a1R6CwHC4+0GXKevmgM9QqgbGGZCtLsccn2AYTpuHZ7uw@mail.gmail.com>
References: <af473935-7cb6-e59a-3b52-055d8492248c@st.com>
 <CAK8P3a1R6CwHC4+0GXKevmgM9QqgbGGZCtLsccn2AYTpuHZ7uw@mail.gmail.com>
Message-ID: <36e374f8-cfc9-06bb-f496-296a145d5b6d@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd

On 03/15/2018 03:59 PM, Arnd Bergmann wrote:
> On Thu, Mar 15, 2018 at 10:06 AM, Patrice CHOTARD
> <patrice.chotard@st.com> wrote:
>> Hi Arnd, Kevin, Olof
>>
>> PLease consider this second round of STi dts update for v4.17
>>
>> The following changes since commit 0e04ce02e6a2ac30d21294d8bb2aeceb8489e52b:
>>
>>     ARM: dts: STi: Remove unused clk_ext2f_a9 clock (2018-02-13 13:31:38
>> +0100)
>>
>> are available in the git repository at:
>>
>>     git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti.git
>>
>> for you to fetch changes up to 9a5f4879cd8de167e82f335317c63f2ffdc80129:
>>
>>     ARM: dts: stih4xx: Add missing #sound-dai-cells (2018-03-15 09:52:25
>> +0100)
>>
>> ----------------------------------------------------------------
>>
>> STi DT update:
>>
>> Add missing #sound-dai-cells which fix DT dtc warnings when building
>> with W=1
> 
> You missed a tag name for this one, but I found tags/sti-dt-for-v4.17-round2
> to be the one that matches the commit ID above and pulled that.
> 
>        Arnd
> 

Sorry for that.
I will check that point, i noticed that i got the same issue with the 
previous pull request for STi DT.

Thanks

Patrice
