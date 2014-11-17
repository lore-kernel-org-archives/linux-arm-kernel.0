From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Mon, 17 Nov 2014 10:31:01 +0800
Subject: [PATCH 3/3] ACPI / processor: Rename acpi_(un)map_lsapic() to
 acpi_(un)map_cpu()
In-Reply-To: <1820875.eppNBckBcQ@vostro.rjw.lan>
References: <1414662780-2147-1-git-send-email-hanjun.guo@linaro.org>
 <5452CE9D.6000403@linaro.org> <10283319.F5QMI6fbWn@vostro.rjw.lan>
 <1820875.eppNBckBcQ@vostro.rjw.lan>
Message-ID: <54695DE5.2080309@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-11-15 7:35, Rafael J. Wysocki wrote:
> On Friday, October 31, 2014 11:55:46 PM Rafael J. Wysocki wrote:
>> On Friday, October 31, 2014 07:49:49 AM Hanjun Guo wrote:
>>> On 2014?10?31? 04:12, Rafael J. Wysocki wrote:
>>>> On Thursday, October 30, 2014 05:53:00 PM Hanjun Guo wrote:
>>>>> acpi_map_lsapic() will allocate a logical CPU number and map it to
>>>>> physical CPU id (such as APIC id) for the hot-added CPU, it will also
>>>>> do some mapping for NUMA node id and etc, acpi_unmap_lsapic() will
>>>>> do the reverse.
>>>>>
>>>>> We can see that the name of the function is a little bit confusing and
>>>>> arch dependent so rename them as acpi_(un)map_map() to make arch
>>>>
>>>> That's acpi_(un)map_cpu() I guess?
>>>
>>> ah, yes, typos, it should be acpi_(un)map_cpu(), my fault.
>>> should I send another version?
>>
>> No, I can fix this up.
> 
> I've queued up the series for 3.19, thanks!

Thanks!

Hanjun
