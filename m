From: john.garry@huawei.com (John Garry)
Date: Tue, 27 Feb 2018 10:03:33 +0000
Subject: [PATCH v2 00/11] perf events patches for improved ARM64 support
In-Reply-To: <20180227095028.GG21033@krava>
References: <1519401932-205051-1-git-send-email-john.garry@huawei.com>
 <20180227095028.GG21033@krava>
Message-ID: <057da936-8a4b-050a-6eb7-029965b8f6aa@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/02/2018 09:50, Jiri Olsa wrote:
> On Sat, Feb 24, 2018 at 12:05:21AM +0800, John Garry wrote:
>> This patchset adds support for some perf events features,
>> targeted at ARM64, implemented in a generic fashion.
>>
>> The two main features are as follows:
>> - support for arch/vendor/platform pmu events directory structure
>>    - to support this, topic subdirectory support needs to be dropped
>> - support for parsing standard architecture pmu events
>>
>> On the back of these, the Cavium ThunderX2, ARM Cortex-A53,
>> and HiSilicon hip08 JSONs are relocated/added/updated.
>>
>> In addition, there is a patch to drop mutli-mapfile.csv support and
>> also a bugfix in jevents.c for an error code value.
>>
>> Differences to v1:
>> - Address coding issues from Jiri Olsa in adding arch std event
>>    support (https://lkml.org/lkml/2018/2/6/501)
>> - add patch to drop topic subdirectory support
>> - add patch for bug fix in json_events()
>> - add review tags from Jiri Olsa
>
> can't tell if those json file changes are ok, but for all the code changes:
>

OK, I need Ganapatrao, William, and ARM64 kernel team/experts to check 
the JSONS.

Thanks very much,
John

> Acked-by: Jiri Olsa <jolsa@kernel.org>
>
> thanks,
> jirka
>
> .
>
