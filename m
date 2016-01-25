From: lho@apm.com (Loc Ho)
Date: Mon, 25 Jan 2016 13:28:00 -0800
Subject: [PATCH v2] ARM64: kernel: implement ACPI parking protocol
In-Reply-To: <CAPw-ZT=zm_giCsC1Y6N2vCjCuAh6jDQjuP6SQry029Buztg08Q@mail.gmail.com>
References: <CAPw-ZTmsLqgh6W6R0uLgQjueV7XjaGOD49CYCRYufJ43zT8Kyg@mail.gmail.com>
 <20160108150142.GB10630@red-moon>
 <CAPw-ZT=zm_giCsC1Y6N2vCjCuAh6jDQjuP6SQry029Buztg08Q@mail.gmail.com>
Message-ID: <CAPw-ZT=Zqe-Wsre5LkR06iK6rB4OMYqWhgwbxSbqUrurnMOwcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

On Fri, Jan 8, 2016 at 11:05 AM, Loc Ho <lho@apm.com> wrote:
> Hi,
>
>>
>> [CC'ed Jeremy - I know he is testing this on m400]
>>
>> On Fri, Dec 18, 2015 at 06:12:20PM -0800, Loc Ho wrote:
>>
>> [...]
>>
>>> >> I put it together to make sure that it is there if any platform
>>> >> compliant with it relies on it and more importantly to prevent
>>> >> non-compliant implentations from trickling into the kernel,
>>> >> basically to prevent broken firmware implementations from being
>>> >> considered compliant and "working".
>>> >
>>> > That's a good point. However, AFAIK, AMD are using PSCI already in their
>>> > firmware implementation and that's what we recommend anyway if EL3 is
>>> > available.
>>> >
>>> > So this patch is mainly aimed at X-Gene since other implementations I'm
>>> > aware of have EL3 already. What are the chances of Applied Micro fixing
>>> > their firmware and actually using this patch? (not a question for you;
>>> > I'm hoping some Applied engineers would comment).
>>> >
>>>
>>> Sorry that I missed this. This FW is now fixed and tested with Lorenzo
>>> patch. Though some minor manual patch will be required with recent
>>> kernel. I was going to get some one to ack the patch but got tied up
>>> with other matter. As for availability of the FW, it is currently
>>> internally only and will be available sometime next year for the next
>>> FW release. If any one interested in the FW, you can contact me.
>>
>> I guess that by "some minor manual patch" you meant you had to rebase
>> the patch on top of mainline, I can post an updated version for you to
>> test.
>
> Yes... It don't apply cleanly with newer kernel.
>
>>
>> Mind giving a tested-by if FW has been updated to comply with the specs
>> and tested with my patch applied ?
>
> Yes... Let me know when an newer version is available.

I am following up here. Do you have an ETA on another version against
latest 4.5.rc1?

-Loc
