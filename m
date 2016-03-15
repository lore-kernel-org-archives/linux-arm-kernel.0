From: m-karicheri2@ti.com (Murali Karicheri)
Date: Tue, 15 Mar 2016 16:50:50 -0400
Subject: [PATCH 0/5] Modularize PCI_DW related drivers.
In-Reply-To: <2163039.5ZupTHB3qf@wuerfel>
References: <1454889644-27830-1-git-send-email-paul.gortmaker@windriver.com>
 <2837386.VTD89bjPJz@wuerfel> <56D40F7F.5060204@ti.com>
 <2163039.5ZupTHB3qf@wuerfel>
Message-ID: <56E875AA.7070106@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/01/2016 04:35 PM, Arnd Bergmann wrote:
> On Monday 29 February 2016 14:59:35 Kishon Vijay Abraham I wrote:
>>> }
>>>
>>> You just need to pass the same resource in here htat you pass into
>>> pci_remap_iospace().
>>
>> I still seem to get the abort in ioremap_page_range().
>>
>> Here's the patch I used [3] and here's the kernel log [4].
>>
>> [3] -> http://pastebin.ubuntu.com/15241614/
>> [4] -> http://pastebin.ubuntu.com/15241637/
>>
>>
> 
> Sorry, I'm out of ideas here. The patch looks right to me, but the problem
> looks unchanged.
> 
> 	Arnd
> 

Was there any progress since this last response from Arnd? or is it a TBD?

-- 
Murali Karicheri
Linux Kernel, Keystone
