From: guohanjun@huawei.com (Hanjun Guo)
Date: Sun, 12 Jun 2016 15:09:46 +0800
Subject: [PATCH v4 00/14] fix some type infos and bugs for arm64/of numa
In-Reply-To: <20160607135852.GA20477@arm.com>
References: <1465286898-13828-1-git-send-email-thunder.leizhen@huawei.com>
 <20160607135852.GA20477@arm.com>
Message-ID: <575D0ABA.2010503@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 2016/6/7 21:58, Will Deacon wrote:
> On Tue, Jun 07, 2016 at 04:08:04PM +0800, Zhen Lei wrote:
>> v3 -> v4:
>> 1. Packed three patches of Kefeng Wang, patch6-8.
>> 2. Add 6 new patches(9-15) to enhance the numa on arm64.
>>
>> v2 -> v3:
>> 1. Adjust patch2 and patch5 according to Matthias Brugger's advice, to make the
>>    patches looks more well. The final code have no change. 
>>
>> v1 -> v2:
>> 1. Base on https://lkml.org/lkml/2016/5/24/679
> If you want bug fixes to land in 4.7, you'll need to base them on a
> mainline kernel.
>

Rafael queued ARM64 ACPI NUMA support for 4.8, and this patch set is based
on that with no urgent bugfixes, can this patch set be queued for 4.8?

Thanks
Hanjun
