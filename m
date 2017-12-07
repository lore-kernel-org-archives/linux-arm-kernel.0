From: yao.jin@linux.intel.com (Jin, Yao)
Date: Thu, 7 Dec 2017 08:49:48 +0800
Subject: [PATCH v9 3/5] perf utils: use pmu->is_uncore to detect PMU
 UNCORE devices
In-Reply-To: <20171206134702.GA12234@kernel.org>
References: <20171016183222.25750-1-ganapatrao.kulkarni@cavium.com>
 <20171016183222.25750-4-ganapatrao.kulkarni@cavium.com>
 <6fdad34d-1612-0447-e58e-5c748f92668d@linux.intel.com>
 <CAKTKpr7oM4h_gxj1P=r_J_T5L_Mmtqqj_Uvji-fARKnQRnCP1w@mail.gmail.com>
 <d576d4c6-663c-dfc1-5618-3fa7c5102e7a@linux.intel.com>
 <1f79aa3c-a061-7c55-5d3e-f13638be01ad@linux.intel.com>
 <20171205184242.GA19952@kernel.org>
 <71db0255-af9b-968a-7baa-238d7146f069@linux.intel.com>
 <20171206134702.GA12234@kernel.org>
Message-ID: <ee3254dd-7f03-e70d-8854-23001e0fda0c@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/6/2017 9:47 PM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Dec 06, 2017 at 08:30:37AM +0800, Jin, Yao escreveu:
>>
>>
>> On 12/6/2017 2:42 AM, Arnaldo Carvalho de Melo wrote:
>>> Em Tue, Dec 05, 2017 at 08:35:22PM +0800, Jin, Yao escreveu:
>>>> A quick test with the new patch 'fix_json_v9_2.patch' shows it working.
>>>
>>> I'll take this as a Tested-by: you, ok?
>>
>> Hi Arnaldo,
>>
>> I didn't do a full test for this patch and for the whole patch series.
>>
>> I just do a quick test and it shows that the regression issue which was
>> found in 'perf stat --per-thread' test case is disappear.
>>
>> If you think it's enough for adding Tested-by, that's fine for me. :)
> 
> I guess this addresses at least your previous regression report, so I
> think it is warranted, thanks!
> 
> - arnaldo
>   

That's fine, thanks!

Thanks
Jin Yao
