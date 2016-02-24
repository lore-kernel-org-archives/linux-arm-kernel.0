From: aleksey.makarov@linaro.org (Aleksey Makarov)
Date: Wed, 24 Feb 2016 20:25:16 +0300
Subject: [PATCH v2 3/8] ACPI: add definitions of DBG2 subtypes
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E37E44BCB5@ORSMSX110.amr.corp.intel.com>
References: <1456333819-13482-1-git-send-email-aleksey.makarov@linaro.org>
 <1456333819-13482-4-git-send-email-aleksey.makarov@linaro.org>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37E44BCB5@ORSMSX110.amr.corp.intel.com>
Message-ID: <56CDE77C.2050301@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/24/2016 08:17 PM, Moore, Robert wrote:
> I've got these for the next release of ACPICA

It have not been pulled to linux-next but is required for the patchset.
So I included it here.

> 
> 
>> -----Original Message-----
>> From: Aleksey Makarov [mailto:aleksey.makarov at linaro.org]
>> Sent: Wednesday, February 24, 2016 9:10 AM
>> To: linux-acpi at vger.kernel.org
>> Cc: linux-serial at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-
>> kernel at lists.infradead.org; Aleksey Makarov; Russell King; Greg Kroah-
>> Hartman; Rafael J . Wysocki; Leif Lindholm; Graeme Gregory; Al Stone;
>> Christopher Covington; Len Brown; Moore, Robert; Zheng, Lv;
>> devel at acpica.org
>> Subject: [PATCH v2 3/8] ACPI: add definitions of DBG2 subtypes
>>
>> The recent version of Microsoft Debug Port Table 2 (DBG2) [1] specifies
>> additional serial debug port subtypes.  These constants are also referred
>> by Serial Port Console Redirection Table (SPCR) [2]
>>
>> Add these constants.
>>
>> [1] https://msdn.microsoft.com/en-
>> us/library/windows/hardware/dn639131(v=vs.85).aspx
>> [2] https://msdn.microsoft.com/en-
>> us/library/windows/hardware/dn639132(v=vs.85).aspx
>>
>> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
>> ---
>>  include/acpi/actbl2.h | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h index
>> a4ef625..652f747 100644
>> --- a/include/acpi/actbl2.h
>> +++ b/include/acpi/actbl2.h
>> @@ -371,6 +371,11 @@ struct acpi_dbg2_device {
>>
>>  #define ACPI_DBG2_16550_COMPATIBLE  0x0000
>>  #define ACPI_DBG2_16550_SUBSET      0x0001
>> +#define ACPI_DBG2_ARM_PL011         0x0003
>> +#define ACPI_DBG2_ARM_SBSA_32BIT    0x000D
>> +#define ACPI_DBG2_ARM_SBSA_GENERIC  0x000E
>> +#define ACPI_DBG2_ARM_DCC           0x000F
>> +#define ACPI_DBG2_BCM2835           0x0010
>>
>>  #define ACPI_DBG2_1394_STANDARD     0x0000
>>
>> --
>> 2.7.1
> 
