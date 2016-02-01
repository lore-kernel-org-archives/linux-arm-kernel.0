From: jcm@redhat.com (Jon Masters)
Date: Mon, 01 Feb 2016 00:46:20 -0500
Subject: [PATCH 0/3] ACPI: parse the SPCR table
In-Reply-To: <20160127134559.1065a45f@lxorguk.ukuu.org.uk>
References: <1453722324-22407-1-git-send-email-aleksey.makarov@linaro.org>	<56A6494E.3090303@hurleysoftware.com>	<56A8B570.2060501@linaro.org>
 <20160127134559.1065a45f@lxorguk.ukuu.org.uk>
Message-ID: <56AEF12C.7060801@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/27/2016 08:45 AM, One Thousand Gnomes wrote:
> On Wed, 27 Jan 2016 15:17:52 +0300
> Aleksey Makarov <aleksey.makarov@linaro.org> wrote:
> 
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
>>
>> Here is an excerpt from it:
>>
>>   Patent Notice:
>>   Microsoft is making certain patent rights available for implementations of this specification under two options:
>>   1)  Microsoft?s Community Promise, available at
>>   http://www.microsoft.com/openspecifications/en/us/programs/community-promise/default.aspx; or
>>   2)  The Open Web Foundation Final Specification Agreement Version 1.0 ("OWF 1.0")
>>   as of October 1, 2012, available at http://www.openwebfoundation.org/legal/the-owf-1-0-agreements/owfa-1-0. 
>>
>> I believe that it means that the patch set meets the criteria for submission.  Am I right?
> 
> This is not a forum for legal advice. I would suggest that Linaro
> discusses it privately with the Linux Foundation and Linus and does so
> under attorney-client privilege. The Linux Foundation does have some
> reasons to exist.

Thanks for the reply, Alan. Can folks discuss and let me know off list
if another license change is subsequently requested for this table? I
spoke with Microsoft about this and they graciously made the previous
license change. I am willing to connect additional dots off-list.

Jon.
