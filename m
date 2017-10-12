From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Thu, 12 Oct 2017 14:01:41 +0200
Subject: [PATCHv2 0/7] Add support for USB OTG on STM32F7
In-Reply-To: <8760bk1t1l.fsf@linux.intel.com>
References: <1503930018-536-1-git-send-email-amelie.delaunay@st.com>
 <878tgim24i.fsf@linux.intel.com>
 <04a49088-b615-d7b8-0387-e7bfa32ee19f@st.com>
 <87vajllx8t.fsf@linux.intel.com>
 <1c4180ef-2da6-b420-7c6e-41769608384a@st.com>
 <87sheplsrm.fsf@linux.intel.com>
 <3c36db6d-75fd-1be6-e946-b75a04e3760e@st.com>
 <21df4d0c-075c-0c5a-c39b-b1dd94fe819d@st.com>
 <87efq821tz.fsf@linux.intel.com>
 <d6e8be43-cbb9-89cd-eb3f-b34ac23ad99f@st.com>
 <878tgg1t5a.fsf@linux.intel.com> <8760bk1t1l.fsf@linux.intel.com>
Message-ID: <ed37c11b-7518-9344-6598-c4e4f6301806@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/12/2017 01:53 PM, Felipe Balbi wrote:
> 
> Hi,
> 
> Felipe Balbi <felipe.balbi@linux.intel.com> writes:
>>>>> I thought that patches 1 and 2, as they are "driver" patches, had to be
>>>>> applied on USB tree (so Felipe's one), and the others (3 to 7) had to be
>>>>> applied on STM32-DT tree (Alex's one). Did I miss something?
>>>>
>>>> patch 1 is documentation, right? Without the documentation patch,
>>>> checkpatch will cringe :-) So either way works.
>>>>
>>>> If you insist, I can take 1-2 through my tree. No worries.
>>>
>>> I don't want to insist :) but for me it is better (and more safe) if you
>>> take patch 1&2 in your tree, and will take others in mine.
>>
>> Okay, I'll apply 1&2
> 
> they are now in my testing/next and next branches.

Thanks Felipe
> 
