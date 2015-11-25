From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Wed, 25 Nov 2015 09:45:17 +0800
Subject: [PATCH v3 12/62] ACPICA: ACPI 6.0: Add changes for FADT table
In-Reply-To: <5654583302000078000B85A6@prv-mh.provo.novell.com>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-13-git-send-email-shannon.zhao@linaro.org>
 <5654583302000078000B85A6@prv-mh.provo.novell.com>
Message-ID: <565512AD.6010609@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015/11/24 19:29, Jan Beulich wrote:
>>>> On 17.11.15 at 10:40, <shannon.zhao@linaro.org> wrote:
>> From: Bob Moore <robert.moore@intel.com>
>>
>> ACPICA commit 72b0b6741990f619f6aaa915302836b7cbb41ac4
>>
>> One new 64-bit field at the end of the table.
>> FADT version is now 6.
>>
>> Link: https://github.com/acpica/acpica/commit/72b0b674 
>> Signed-off-by: Bob Moore <robert.moore@intel.com>
>> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> [Linux commit aeb823bbacc2a3aaee29eda5875b58a049fa1f78]
>> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
>> ---
>>  xen/include/acpi/actbl.h | 17 ++++++++++-------
>>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> So while I applied this one after fixing it up, I'm not going to do any
> further fixups to later patches I also meant to apply. I realize the
> fixups may have been necessary because of me applying them in
> other than the submitted sequence, but then again such general
> imports from ACPICA/Linux should have been independent of
> earlier changes. I.e. either earlier patches in the series wrongly
> touch these headers, or there's a general problem with the series.
> 
I will split this patch set in several parts and the first part would be
the changes and updates of ACPI SPEC 5.0~6.0. So maybe you could apply
them at next version.

Thanks,
-- 
Shannon
