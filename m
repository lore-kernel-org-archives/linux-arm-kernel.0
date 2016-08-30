From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Tue, 30 Aug 2016 17:47:25 +0200
Subject: [PATCH v2 0/8] ARM: V7M: Support caches
In-Reply-To: <57B5CCDE.10504@arm.com>
References: <1471524360-31554-1-git-send-email-vladimir.murzin@arm.com>
 <20160818145300.GA1041@n2100.armlinux.org.uk> <57B5CCDE.10504@arm.com>
Message-ID: <8a0c4963-4f22-9914-b2c8-046bba8b9764@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vladimir,

On 08/18/2016 04:57 PM, Vladimir Murzin wrote:
> On 18/08/16 15:53, Russell King - ARM Linux wrote:
>> On Thu, Aug 18, 2016 at 01:45:52PM +0100, Vladimir Murzin wrote:
>>> This patch set allows M-class cpus benefit of optional cache support.
>>> It originally was written by Jonny, I've been keeping it locally mainly
>>> rebasing over Linux versions.
>>>
>>> The original idea behind patches was to reuse existing cache handling
>>> code from v7A/R with help of extra macros to factor out cache handling
>>> logic (v7M cache operations are provided via memory mapped interface
>>> rather than co-processor instructions).
>>> However, that idea was rejected and starting form this (v2) version
>>> V7M cache logic lives into file and macros to indirect memory-mapped
>>> operations stay there locally since they make it easier to follow the
>>> code.
>>>
>>> Along with the v7M cache support the first user (Cortex-M7) is
>>> introduced.
>>>
>>> Patches were tested on MPS2 platform with Cortex-M3/M4/M7. The later
>>> one showed significant boot speed-up.
>>
>> >From a quick read through, the approach looks sane, and I think I'm
>> now happy with these.
>>
>
> Thanks!
>
> Is it acceptable if patches hang on a list for awhile, so people (I'm
> looking at Alex and  Szemz?) can test them?

I just tested this v2 patch set. I don't see behavior issues.
You can add:
Tested-by: Alexandre TORGUE <alexandre.torgue@st.com>

Regards

Alex

>
> Vladimir
>
>> Thanks.
>>
>
