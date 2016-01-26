From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 26 Jan 2016 08:31:39 +0000
Subject: [PATCH v4 1/2] acpi: Fix proper return code for function
 acpi_gsi_to_irq
In-Reply-To: <CAPw-ZTnm5F3Kt+_J6HoNCYbx8R7JVkME5yA9V-hAwRtr8ge9ZA@mail.gmail.com>
References: <1453335459-3617-1-git-send-email-lho@apm.com>
 <1453335459-3617-2-git-send-email-lho@apm.com>
 <CAPw-ZTnm5F3Kt+_J6HoNCYbx8R7JVkME5yA9V-hAwRtr8ge9ZA@mail.gmail.com>
Message-ID: <56A72EEB.5040205@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Loc,

On 25/01/16 21:23, Loc Ho wrote:
> Hi,
> 
> On Wed, Jan 20, 2016 at 4:17 PM, Loc Ho <lho@apm.com> wrote:
>>
>> The function acpi_gsi_to_irq must return 0 on success as the caller
>> ghes_probe expects an 0 for success. This change also matches x86
>> implementation.
>>
>> Signed-off-by: Tuan Phan <tphan@apm.com>
>> Signed-off-by: Loc Ho <lho@apm.com>
> 
> 
> Any issue with this version? If not, can this be pulled into 4.5?

How is that 4.5 material? Does it fix an observable bug or a regression
from a previous? If not, then this is probably to be postponed until
4.6, together with the code that makes use of it.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
