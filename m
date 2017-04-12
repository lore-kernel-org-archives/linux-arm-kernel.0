From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 12 Apr 2017 10:33:49 +0800
Subject: [RFC PATCH 4/7] ACPICA: IORT: Add SMMuV3 model definitions.
In-Reply-To: <CA+sq2CfXQAM-ooNRQBbYNYc_T=p2yrvA2FYD=2_=_-Z9kQwVcA@mail.gmail.com>
References: <1491921765-29475-1-git-send-email-linucherian@gmail.com>
 <1491921765-29475-5-git-send-email-linucherian@gmail.com>
 <d60a1fcc-081e-03e8-3454-6802e830ddb9@arm.com>
 <CA+sq2CfXQAM-ooNRQBbYNYc_T=p2yrvA2FYD=2_=_-Z9kQwVcA@mail.gmail.com>
Message-ID: <e40bacb5-0341-dde8-eee7-894b199da7ca@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017/4/12 0:57, Sunil Kovvuri wrote:
> On Tue, Apr 11, 2017 at 9:29 PM, Robin Murphy <robin.murphy@arm.com> wrote:
>> On 11/04/17 15:42, linucherian at gmail.com wrote:
>>> From: Linu Cherian <linu.cherian@cavium.com>
>>>
>>> Add SMMuV3 model definitions.
>>>
>>> Signed-off-by: Linu Cherian <linu.cherian@cavium.com>
>>> ---
>>>  include/acpi/actbl2.h | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
>>> index 2b4af07..9db67d6 100644
>>> --- a/include/acpi/actbl2.h
>>> +++ b/include/acpi/actbl2.h
>>> @@ -778,6 +778,11 @@ struct acpi_iort_smmu {
>>>  #define ACPI_IORT_SMMU_CORELINK_MMU400  0x00000002   /* ARM Corelink MMU-400 */
>>>  #define ACPI_IORT_SMMU_CORELINK_MMU500  0x00000003   /* ARM Corelink MMU-500 */
>>>
>>> +#define ACPI_IORT_SMMU_V3               0x00000000      /* Generic SMMUv3 */
>>> +#define ACPI_IORT_SMMU_CORELINK_MMU600  0x00000001      /* ARM Corelink MMU-600 */
>>> +#define ACPI_IORT_SMMU_V3_HISILICON     0x00000002      /* HiSilicon SMMUv3 */
>>> +#define ACPI_IORT_SMMU_V3_CAVIUM_CN99XX 0x00000003      /* Cavium CN99xx SMMUv3 */
>>
>> None of those models are listed in the current IORT spec.
>
> As mentioned in the cover letter, we are in the process of getting
> model no added for
> our silicon in the soon to be published updated IORT spec. Meanwhile
> we wanted to take
> feedback on the errata patches from experts. Hence patches were
> submitted as RFC.

Thanks. The name for Hisilicon SMMUv3 might be changed, we need to wait
for the released IORT spec.

Thanks
Hanjun
