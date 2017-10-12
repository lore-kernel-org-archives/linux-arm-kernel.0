From: gklkml16@gmail.com (Ganapatrao Kulkarni)
Date: Thu, 12 Oct 2017 19:17:53 +0530
Subject: [PATCH v7 0/4] Add support for ThunderX2 pmu events using json
 files
In-Reply-To: <e1a2913c-f56f-44c5-19e7-0c061cf21639@hisilicon.com>
References: <20171012103419.29824-1-ganapatrao.kulkarni@cavium.com>
 <20171012103820.GC17924@rric.localdomain>
 <CAKTKpr5=msG9b-f2Mj+1SibUvMXefg9DAcNA7M3hgHCX=hpQ6g@mail.gmail.com>
 <20171012105851.GC7395@arm.com>
 <e1a2913c-f56f-44c5-19e7-0c061cf21639@hisilicon.com>
Message-ID: <CAKTKpr4zqOUJraeCsHH2BFtf3C9a6brTbt94cikOvQe7Y3V0zw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 12, 2017 at 5:15 PM, Zhangshaokun
<zhangshaokun@hisilicon.com> wrote:
> Hi Will,
>
> On 2017/10/12 18:58, Will Deacon wrote:
>> On Thu, Oct 12, 2017 at 04:20:06PM +0530, Ganapatrao Kulkarni wrote:
>>> Hi Robert,
>>>
>>> On Thu, Oct 12, 2017 at 4:08 PM, Robert Richter <rric@kernel.org> wrote:
>>>> On 12.10.17 16:04:15, Ganapatrao Kulkarni wrote:
>>>>
>>>>>  tools/perf/arch/arm64/util/Build                   |  1 +
>>>>>  tools/perf/arch/arm64/util/header.c                | 65 ++++++++++++++++++++++
>>>>>  tools/perf/arch/powerpc/util/header.c              |  2 +-
>>>>>  tools/perf/arch/x86/util/header.c                  |  2 +-
>>>>>  tools/perf/pmu-events/arch/arm64/mapfile.csv       | 15 +++++
>>>>>  .../arch/arm64/thunderx2/thunderx2-imp-def.json    | 62 +++++++++++++++++++++
>>>>
>>>> I guess the dir needs to be named 'cavium'.
>>>
>>> i dont think so ,  while compilation arch type is detected, it has to be arm64
>>> refer SRCARCH in pmu-events/Build
>>
>> The full name should be:
>>
>> .../arch/arm64/cavium/thunderx2-imp-def.json

ok,  i am sending patch with renaming directory to cavium.

>>
>
> It works for us (HiSilicon) as .../arch/arm64/hisilicon/hip08-imp-def.json.
>
> Thanks,
> Shaokun
>
>> Will
>>
>> .
>>
>

thanks
Ganapat
