From: rafael@kernel.org (Rafael J. Wysocki)
Date: Sat, 8 Aug 2015 02:28:38 +0200
Subject: [PATCH 2/2] net, thunder, bgx: Add support for ACPI binding.
In-Reply-To: <55C5494D.5010903@caviumnetworks.com>
References: <1438907590-29649-1-git-send-email-ddaney.cavm@gmail.com>
 <1438907590-29649-3-git-send-email-ddaney.cavm@gmail.com>
 <20150807140106.GE7646@leverpostej>
 <55C4ECC6.7050908@caviumnetworks.com>
 <20150807175127.GB12013@leverpostej>
 <CAJZ5v0gc=bo3ayO7aWq19Hh_205YC52wqXGbbM5vxR1atXm+oA@mail.gmail.com>
 <55C5494D.5010903@caviumnetworks.com>
Message-ID: <CAJZ5v0iNqRsrpwzWY5o97R1S+Dr-CzRPg3Cymt1q4v5gvABCQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On Sat, Aug 8, 2015 at 2:11 AM, David Daney <ddaney@caviumnetworks.com> wrote:
> On 08/07/2015 05:05 PM, Rafael J. Wysocki wrote:

[cut]

>>
>> It is actually useful to people as far as I can say.
>>
>> Also, if somebody is going to use properties with ACPI, why whould
>> they use a different set of properties with DT?
>>
>> Wouldn't it be more reasonable to use the same set in both cases?
>
>
> Yes, but there is still quite a bit of leeway to screw things up.

That I have to agree with, unfortunately.

On the other hand, this is a fairly new concept and we need to gain
some experience with it to be able to come up with best practices and
so on.  Cases like yours are really helpful here.

> FWIW:  http://www.uefi.org/sites/default/files/resources/nic-request-v2.pdf
>
> This actually seems to have been adopted by the UEFI people as a
> "Standard", I am not sure where a record of this is kept though.

Work on this is in progress, but far from completion.  Essentially,
what's needed is more pressure from vendors who want to use properties
in their firmware.

> So, we are changing our firmware to use this standard (which is quite
> similar the the DT with respect to MAC addresses).

Cool. :-)

Thanks,
Rafael
