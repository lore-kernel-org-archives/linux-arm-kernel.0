From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Mon, 13 Jun 2016 18:29:09 +0200
Subject: [PATCH 00/10] ARM: V7M: Support caches
In-Reply-To: <575EDD28.40500@arm.com>
References: <1465830189-20128-1-git-send-email-vladimir.murzin@arm.com>
 <575EDAB9.2070809@st.com> <575EDD28.40500@arm.com>
Message-ID: <575EDF55.2020304@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vladimir,

On 06/13/2016 06:19 PM, Vladimir Murzin wrote:
> Hi Alex,
>
> On 13/06/16 17:09, Alexandre Torgue wrote:
>> Hi Vladimir,
>>
>> On 06/13/2016 05:02 PM, Vladimir Murzin wrote:
>>> Hi,
>>>
>>> This patch set allows M-class cpus benefit of optional cache support.
>>> It originaly was written by Jonny, I've been keeping it localy mainly
>>> rebasing over Linux versions.
>>>
>>> The main idea behind patches is to reuse existing cache handling code
>>> from v7A/R. In case v7M cache operations are provided via memory
>>> mapped interface rather than co-processor instructions, so extra
>>> macros have been introduced to factor out cache handling logic and
>>> low-level operations.
>>>
>>> Along with the v7M cache support the first user (Cortex-M7) is
>>> introduced.
>>>
>>> Patches were tested on MPS2 platform with Cortex-M3/M4/M7. The later
>>> one showed significant boot speed-up.
>>>
>>> Based on 4.7-rc3.
>>>
>>> Thanks!
>>> Vladimir
>>>
>>
>> Thanks for the series.
>> Did you change something in those patches compare to patches you sent in
>> the RFC ?
>
> Only 04, 05, 06 have been changed (each has it's own changelog included).
>
> I did try to hammer patches because of your report of instability with
> caches on, but all run fine... so nothing has been changed in regard of
> your case.
>
Ok. Thanks for this input. From now, I will use this series to perform 
my tests. I will continue to debug my instabilities this week.
I will let you know.

Regards

Alex
