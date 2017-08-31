From: zhangshaokun@hisilicon.com (Zhangshaokun)
Date: Thu, 31 Aug 2017 18:29:01 +0800
Subject: [PATCH v6 4/4] perf vendor events arm64: Add ThunderX2
 implementation defined pmu core events
In-Reply-To: <20170829124730.GH17961@rric.localdomain>
References: <20170824120349.2323-1-ganapatrao.kulkarni@cavium.com>
 <20170824120349.2323-5-ganapatrao.kulkarni@cavium.com>
 <43dcc107-263a-5429-73d4-a5290c6610d6@hisilicon.com>
 <20170829124730.GH17961@rric.localdomain>
Message-ID: <b7c40672-8997-c202-7cc2-35b8bc79ecda@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert,

On 2017/8/29 20:47, Robert Richter wrote:
> Shaokun,
> 
> On 29.08.17 17:26:00, Zhangshaokun wrote:
>> On 2017/8/24 20:03, Ganapatrao Kulkarni wrote:
>>> This is not a full event list, but a short list of useful events.
>>>
>>> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
>>> ---
>>>  tools/perf/pmu-events/arch/arm64/mapfile.csv       | 15 ++++++
>>>  .../arm64/thunderx2/implementation-defined.json    | 62 ++++++++++++++++++++++
>>>  2 files changed, 77 insertions(+)
>>>  create mode 100644 tools/perf/pmu-events/arch/arm64/mapfile.csv
>>>  create mode 100644 tools/perf/pmu-events/arch/arm64/thunderx2/implementation-defined.json
>>>
>>
>> I saw you also used thunderx2 in tools/perf/pmu-events/arch/arm64/, how about John's suggestion
>> that would use vendor sub-folder?
>> Of course, appreciate maintainer's comments.
> 
> this would just add another level of subdirectories. I rather would
> prefer to have a per platform dir comparable to what is listed in
> 
>  arch/arm64/Kconfig.platforms
> 

Check it again that not all vendors have specific platform config per SoC family,
so this would not work for us (HiSilicon) and maybe some other vendors.

Thanks,
Shaokun

> This is the same as Ganapat has implemented it.
> 
> -Robert
> 
> 
