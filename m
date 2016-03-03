From: peter@hurleysoftware.com (Peter Hurley)
Date: Thu, 3 Mar 2016 12:08:36 -0800
Subject: [PATCH 0/3] ACPI: parse the SPCR table
In-Reply-To: <56BBCA2F.3020604@redhat.com>
References: <1453722324-22407-1-git-send-email-aleksey.makarov@linaro.org>
 <56A6494E.3090303@hurleysoftware.com> <56A8B570.2060501@linaro.org>
 <56BBCA2F.3020604@redhat.com>
Message-ID: <56D899C4.5050802@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Al,

Somehow your email was filtered. Apologies for that.

On 02/10/2016 03:39 PM, Al Stone wrote:
> On 01/27/2016 05:17 AM, Aleksey Makarov wrote:
>>
>>
>> On 01/25/2016 07:11 PM, Peter Hurley wrote:
>>> On 01/25/2016 03:45 AM, Aleksey Makarov wrote:
>>>> This patchset is based on the patchset by Leif Lindholm [1]
>>>>
>>>> 'ARM Server Base Boot Requirements' [2] mention SPCR 
>>>> (Serial Port Console Redirection Table) [3] as a mandatory
>>>> ACPI table that specifies the configuration of serial console.
>>>>
>>>> Licensing concerns have prevented implementing it in the past, but as of
>>>> 10 August 2015, these tables have both been released also under 
>>>> OWF 1.0 [4].
>>>
>>> This license has a patent retaliation provision, which makes it
>>> incompatible with GPLv2.
>>>
>>> *If the license applies to this code*, then this patch set does not
>>> meet the criteria for submission.
>>
>> The license applies not to this code but to the document describing the tables.
> 
> Just for the record, the SPCR table struct definition has been part
> of the Linux kernel since at least commit b24aad44 on 2009-07-24
> (line 1112 of include/acpi/actbl2.h) -- or so git blame tells me.

Just to be clear here:

The Microsoft specification, which defines the SPCR table struct and which
this patch series relies on, notes that patents apply. Specifically, it
says:

Patent Notice:
Microsoft is making certain patent rights available for implementations of this specification under two options:
1)  Microsoft?s Community Promise, available at http://www.microsoft.com/openspecifications/en/us/programs/community-promise/default.aspx; or
2)  The Open Web Foundation Final Specification Agreement Version 1.0 ("OWF 1.0") as of October 1, 2012, available at http://www.openwebfoundation.org/legal/the-owf-1-0-agreements/owfa-1-0. 
Version 1.03 ? August 10, 2015

I don't believe either of those patent licenses are GPL compatible.

Unless you're saying Red Hat is signing off on this?

Regards,
Peter Hurley
