From: ddaney.cavm@gmail.com (David Daney)
Date: Fri, 5 May 2017 07:56:17 -0700
Subject: [PATCH v3 3/7] ACPICA: IORT: Add Cavium ThunderX2 SMMUv3 model
 definition.
In-Reply-To: <330d0438-f9ed-ef65-8ffd-d556d149b4e1@linaro.org>
References: <1493986091-30521-1-git-send-email-gakula@caviumnetworks.com>
 <1493986091-30521-4-git-send-email-gakula@caviumnetworks.com>
 <330d0438-f9ed-ef65-8ffd-d556d149b4e1@linaro.org>
Message-ID: <6b04ab17-449f-74e0-72f4-b5a9bc0639d8@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/05/2017 06:53 AM, Hanjun Guo wrote:
> On 2017/5/5 20:08, Geetha sowjanya wrote:
>> From: Linu Cherian <linu.cherian@cavium.com>
>>
>> Add SMMUv3 model definition for ThunderX2.
>>
>> Signed-off-by: Linu Cherian <linu.cherian@cavium.com>
>> Signed-off-by: Geetha Sowjanya <geethasowjanya.akula@cavium.com>
>> ---
>>  include/acpi/actbl2.h | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
>> index faa9f2c..76a6f5d 100644
>> --- a/include/acpi/actbl2.h
>> +++ b/include/acpi/actbl2.h
>> @@ -779,6 +779,8 @@ struct acpi_iort_smmu {
>>  #define ACPI_IORT_SMMU_CORELINK_MMU400  0x00000002    /* ARM Corelink 
>> MMU-400 */
>>  #define ACPI_IORT_SMMU_CORELINK_MMU500  0x00000003    /* ARM Corelink 
>> MMU-500 */
>>
>> +#define ACPI_IORT_SMMU_V3_CAVIUM_CN99XX 0x00000002 /* Cavium 
>> ThunderX2 SMMUv3 */
> 
> There are some other model numbers in the unreleased spec,
> I think we need to wait for the updated IORT spec to
> be released.
> 

... or if we are fairly confident that the identifier will not need to 
change, we can merge this as is and establish a de facto specification 
that the Real IORT specification will then be forced to follow.

Is there anything other than bureaucratic inertia holding up the real 
specification?


David.
