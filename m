From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 9 Dec 2013 19:39:46 -0500
Subject: [PATCH] mm: nobootmem: avoid type warning about alignment value
In-Reply-To: <20131125155629.GA24344@htj.dyndns.org>
References: <1385249326-9089-1-git-send-email-santosh.shilimkar@ti.com>
 <529217C7.6030304@cogentembedded.com> <52935762.1080409@ti.com>
 <20131125155629.GA24344@htj.dyndns.org>
Message-ID: <52A662D2.9010201@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew,

On Monday 25 November 2013 10:56 AM, Tejun Heo wrote:
> On Mon, Nov 25, 2013 at 08:57:54AM -0500, Santosh Shilimkar wrote:
>> On Sunday 24 November 2013 10:14 AM, Sergei Shtylyov wrote:
>>> Hello.
>>>
>>> On 24-11-2013 3:28, Santosh Shilimkar wrote:
>>>
>>>> Building ARM with NO_BOOTMEM generates below warning. Using min_t
>>>
>>>    Where is that below? :-)
>>>
>> Damn.. Posted a wrong version of the patch ;-(
>> Here is the one with warning message included.
>>
>> From 571dfdf4cf8ac7dfd50bd9b7519717c42824f1c3 Mon Sep 17 00:00:00 2001
>> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Date: Sat, 23 Nov 2013 18:16:50 -0500
>> Subject: [PATCH] mm: nobootmem: avoid type warning about alignment value
>>
>> Building ARM with NO_BOOTMEM generates below warning.
>>
>> mm/nobootmem.c: In function ?__free_pages_memory?:
>> mm/nobootmem.c:88:11: warning: comparison of distinct pointer types lacks a cast
>>
>> Using min_t to find the correct alignment avoids the warning.
>>
>> Cc: Tejun Heo <tj@kernel.org>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> 
Can you please this warning fix as well in your mm tree ?

Regards,
Santosh
