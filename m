From: guohanjun@huawei.com (Hanjun Guo)
Date: Thu, 12 Oct 2017 18:58:33 +0800
Subject: [PATCH 0/2] arm64 SMMUv3 PMU driver with IORT support
In-Reply-To: <67a696ad-98e9-d505-1d73-7246d2efc398@codeaurora.org>
References: <1501876754-1064-1-git-send-email-nleeder@codeaurora.org>
 <394bd3b8-2583-01fa-02d3-6a49c2a6a6c0@linaro.org>
 <3eac1295-dba2-ad79-d868-b538b13de91a@codeaurora.org>
 <f1d864be-8ce4-f2d2-9c71-8fff202a76d1@linaro.org>
 <67a696ad-98e9-d505-1d73-7246d2efc398@codeaurora.org>
Message-ID: <59DF4AD9.2060903@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017/8/11 11:28, Leeder, Neil wrote:
> On 8/9/2017 9:26 PM, Hanjun Guo wrote:
>> > On 2017/8/9 23:48, Leeder, Neil wrote:
>>>>> >>>>    drivers/perf/Kconfig          |   9 +
>>>>> >>>>    drivers/perf/Makefile         |   1 +
>>>>> >>>>    drivers/perf/arm_smmuv3_pmu.c | 823 ++++++++++++++++++++++++++++++++++++++++++
>>>>> >>>>    include/acpi/actbl2.h         |   9 +-
>>>> >>> Do you have the acpica support code? I'm currently
>>>> >>> working on SMMUv3 MSI support and I would like to test
>>>> >>> it with MSI support for PMCG as well.
>>> >> I don't have any code other than what was posted here.
>>> >> What additional ACPICA support code is needed?
>> > 
>> > Sorry for not clear, I mean the acpica code for iASL and
>> > other tool: github.com/acpica/acpica.git
>> > 
>> > With that code, I can compile my IORT table with PMCG node.
> Unfortunately it looks like I'm the first person from Qualcomm Datacenter
> Technologies to try to add something to ACPICA, which means I'll have to
> kick off an internal legal process which may take some time. Unless someone
> else wants to take a crack at it - and really, there's nothing more than is
> in the ARM IORT spec - it could be a while before I can do that.

Just a update, I sent a pull request to Bob for ACPICA changes,
please take a look:

https://github.com/acpica/acpica/pull/327

Thanks
Hanjun
