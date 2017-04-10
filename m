From: mayurkumar.patel@intel.com (Patel, Mayurkumar)
Date: Mon, 10 Apr 2017 13:11:32 +0000
Subject: [PATCH V8 0/5] PCI/ASPM: reconfigure ASPM following hotplug for
 POLICY_DEFAULT
In-Reply-To: <33d18b40-8449-78a5-7127-9988d846d179@codeaurora.org>
References: <1491627351-1111-1-git-send-email-okaya@codeaurora.org>
 <92EBB4272BF81E4089A7126EC1E7B284667665E7@IRSMSX101.ger.corp.intel.com>
 <33d18b40-8449-78a5-7127-9988d846d179@codeaurora.org>
Message-ID: <92EBB4272BF81E4089A7126EC1E7B2846676674D@IRSMSX101.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
>On 4/10/2017 7:37 AM, Patel, Mayurkumar wrote:
>>> PCI/ASPM: save power on values during bridge init
>>>  PCI/ASPM: move link_state cleanup to bridge remove
>>>
>> Thanks Sinan for new patches. No issues seen so far in my testing for L1 and L1SS both.
>> May you please add my tested-by in the patches?
>>
>> I will keep on testing it and let you know if something goes wrong for any
>> corner case.
>>
>
>Thanks for testing and providing your tested-by.

Tested-by: Mayurkumar Patel <mayurkumar.patel@intel.com>

>
>--
>Sinan Kaya
>Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
>Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
Intel Deutschland GmbH
Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
Tel: +49 89 99 8853-0, www.intel.de
Managing Directors: Christin Eisenschmid, Christian Lamprechter
Chairperson of the Supervisory Board: Nicole Lau
Registered Office: Munich
Commercial Register: Amtsgericht Muenchen HRB 186928
