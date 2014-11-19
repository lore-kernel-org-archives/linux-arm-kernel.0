From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 19 Nov 2014 08:34:42 +0800
Subject: [PATCH v5 03/18] ACPI / table: Count matched and successfully
 parsed entries without specifying max entries
In-Reply-To: <7743567.TJcygJtKD3@vostro.rjw.lan>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>
 <1413553034-20956-4-git-send-email-hanjun.guo@linaro.org>
 <546B4EDD.9050804@linaro.org> <7743567.TJcygJtKD3@vostro.rjw.lan>
Message-ID: <546BE5A2.6030101@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-11-19 4:15, Rafael J. Wysocki wrote:
> On Tuesday, November 18, 2014 09:51:25 PM Hanjun Guo wrote:
>> Hi Rafael,
>>
>> On 2014?10?17? 21:36, Hanjun Guo wrote:
>>> From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>>>
>>> It is very useful to traverse all available table entries without max
>>> number of expected entries type. Current acpi_parse_entries()
>>> implementation gives that feature but it does not count those entries,
>>> it returns 0 instead, so fix it to count matched and successfully
>>> entries and return it.
>>>
>>> NOTE: This change has no impact to x86 and ia64 archs since existing code
>>> checks for error occurrence only (acpi_parse_entries(...,0) < 0).
>>>
>>> Acked-by: Grant Likely <grant.likely@linaro.org>
>>> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>>
>> Patch 2 and patch 3 are only for ACPI cores, and have no harm to x86
>> and IA64, could you merge first in 3.19?
> 
> I can do that if that helps.

Yes, it helps to keep the next version of ARM64 ACPI patch set smaller
and easy for review. If any rebase work needed, please let me know.

Thanks
Hanjun
