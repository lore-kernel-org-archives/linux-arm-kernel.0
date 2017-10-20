From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Fri, 20 Oct 2017 09:33:33 +0200
Subject: [GIT PULL] STM32 defconfig changes for v4.15 #1
In-Reply-To: <CAK8P3a3sfq13v8sVox8xiXvHpSyzsvV_4LEYsoNtdfLLhyS7MA@mail.gmail.com>
References: <8c7fe79d-ebd3-ee7c-f056-1d3aa225edee@st.com>
 <CAK8P3a3sfq13v8sVox8xiXvHpSyzsvV_4LEYsoNtdfLLhyS7MA@mail.gmail.com>
Message-ID: <e984aa91-cf82-8823-1cd6-ed0d194bd5ba@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 10/19/2017 10:57 PM, Arnd Bergmann wrote:
> On Tue, Oct 17, 2017 at 12:16 PM, Alexandre Torgue
> <alexandre.torgue@st.com> wrote:
>> ----------------------------------------------------------------
>> STM32 defconfig updates for v4.15, round 1
>>
>> Highlights:
>> ----------
>>   -Regenerate default configuration
>>   -Add DMAMUX support
>>   -Add I2C F7 support
>>   -Add MDMA support
> 
> Pulled into next/soc.
> 
> Splitting out the first patch is fine, but there really is no need to have one
> patch per new Kconfig option you enable, it's less work and more readable to
> have a combined patch that explains what the options are and why you need
> all of them.
> 
>          Arnd
> 

ok. So you mean I would have to merge "Add DMAMUX support", "Add I2C F7 
support", "Add MDMA support" in one patch before to submit the pull 
request ? If yes, it will be done for next PR.

Thanks
Alex
