From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 08 Apr 2014 20:21:18 +0800
Subject: [PATCH V2] ACPI: Update the ownership and developers for ACPI
 in Kconfig
In-Reply-To: <3442476.Y3PYFAt6A7@vostro.rjw.lan>
References: <1396956241-8337-1-git-send-email-hanjun.guo@linaro.org>
 <3442476.Y3PYFAt6A7@vostro.rjw.lan>
Message-ID: <5343E9BE.7030608@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

On 2014-4-8 20:01, Rafael J. Wysocki wrote:
> On Tuesday, April 08, 2014 07:24:01 PM Hanjun Guo wrote:
>> The UEFI Forum included the ACPI spec in its portfolio in October 2013
>> and will host future spec iterations, following the ACPI v5.0a release.
>>
>> A UEFI Forum working group named ACPI Specification Working Group (ASWG)
>> has been established to handle future ACPI developments, any UEFI member
>> can join the group and contribute to ACPI specification.
>>
>> So update the ownership and developers for ACPI in Kconfig accordingly,
>> and add another website link to ACPI specification too.
>>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>  drivers/acpi/Kconfig |    4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> index c205653..6bbf36e 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -32,9 +32,11 @@ menuconfig ACPI
>>  	  <http://acpica.org/>
>>  
>>  	  ACPI is an open industry specification co-developed by
>> -	  Hewlett-Packard, Intel, Microsoft, Phoenix, and Toshiba.
>> +	  ACPI Specification Working Group (ASWG) under UEFI Forum, any
>> +	  UEFI member can join ASWG and contribute to ACPI specification.
> 
> Thinking a bit more about that, I'd prefer this wording:
> 
> 	ACPI is an open industry specification originally co-developed by
> 	Hewlett-Packard, Intel, Microsoft, Phoenix, and Toshiba.  Currently,
> 	it is developed by the ACPI Specification Working Group (ASWG) under
> 	the UEFI Forum and any UEFI member can join the ASWG and contribute
> 	to the ACPI specification.

Great, I like your wording very much, will sent another version shortly :)

Thanks
Hanjun
