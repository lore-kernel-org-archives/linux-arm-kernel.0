From: ahs3@redhat.com (Al Stone)
Date: Wed, 10 Feb 2016 16:39:27 -0700
Subject: [PATCH 0/3] ACPI: parse the SPCR table
In-Reply-To: <56A8B570.2060501@linaro.org>
References: <1453722324-22407-1-git-send-email-aleksey.makarov@linaro.org>
 <56A6494E.3090303@hurleysoftware.com> <56A8B570.2060501@linaro.org>
Message-ID: <56BBCA2F.3020604@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/27/2016 05:17 AM, Aleksey Makarov wrote:
> 
> 
> On 01/25/2016 07:11 PM, Peter Hurley wrote:
>> On 01/25/2016 03:45 AM, Aleksey Makarov wrote:
>>> This patchset is based on the patchset by Leif Lindholm [1]
>>>
>>> 'ARM Server Base Boot Requirements' [2] mention SPCR 
>>> (Serial Port Console Redirection Table) [3] as a mandatory
>>> ACPI table that specifies the configuration of serial console.
>>>
>>> Licensing concerns have prevented implementing it in the past, but as of
>>> 10 August 2015, these tables have both been released also under 
>>> OWF 1.0 [4].
>>
>> This license has a patent retaliation provision, which makes it
>> incompatible with GPLv2.
>>
>> *If the license applies to this code*, then this patch set does not
>> meet the criteria for submission.
> 
> The license applies not to this code but to the document describing the tables.

Just for the record, the SPCR table struct definition has been part
of the Linux kernel since at least commit b24aad44 on 2009-07-24
(line 1112 of include/acpi/actbl2.h) -- or so git blame tells me.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3 at redhat.com
-----------------------------------
