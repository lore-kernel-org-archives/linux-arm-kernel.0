From: aleksey.makarov@linaro.org (Aleksey Makarov)
Date: Wed, 27 Jan 2016 15:17:52 +0300
Subject: [PATCH 0/3] ACPI: parse the SPCR table
In-Reply-To: <56A6494E.3090303@hurleysoftware.com>
References: <1453722324-22407-1-git-send-email-aleksey.makarov@linaro.org>
 <56A6494E.3090303@hurleysoftware.com>
Message-ID: <56A8B570.2060501@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/25/2016 07:11 PM, Peter Hurley wrote:
> On 01/25/2016 03:45 AM, Aleksey Makarov wrote:
>> This patchset is based on the patchset by Leif Lindholm [1]
>>
>> 'ARM Server Base Boot Requirements' [2] mention SPCR 
>> (Serial Port Console Redirection Table) [3] as a mandatory
>> ACPI table that specifies the configuration of serial console.
>>
>> Licensing concerns have prevented implementing it in the past, but as of
>> 10 August 2015, these tables have both been released also under 
>> OWF 1.0 [4].
> 
> This license has a patent retaliation provision, which makes it
> incompatible with GPLv2.
> 
> *If the license applies to this code*, then this patch set does not
> meet the criteria for submission.

The license applies not to this code but to the document describing the tables.

Here is an excerpt from it:

  Patent Notice:
  Microsoft is making certain patent rights available for implementations of this specification under two options:
  1)  Microsoft?s Community Promise, available at
  http://www.microsoft.com/openspecifications/en/us/programs/community-promise/default.aspx; or
  2)  The Open Web Foundation Final Specification Agreement Version 1.0 ("OWF 1.0")
  as of October 1, 2012, available at http://www.openwebfoundation.org/legal/the-owf-1-0-agreements/owfa-1-0. 

I believe that it means that the patch set meets the criteria for submission.  Am I right?

Thank you
Aleksey Makarov
