From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 5 Dec 2013 07:28:12 -0500
Subject: [GIT PULL for-next] ARM: mm: Switch ARM port to NO_BOOTMEM for
 3.14
In-Reply-To: <20131205103352.GD4360@n2100.arm.linux.org.uk>
References: <1386017539-10295-1-git-send-email-santosh.shilimkar@ti.com>
 <20131205103352.GD4360@n2100.arm.linux.org.uk>
Message-ID: <52A0715C.30000@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 05 December 2013 05:33 AM, Russell King - ARM Linux wrote:
> On Mon, Dec 02, 2013 at 03:52:19PM -0500, Santosh Shilimkar wrote:
>> Russell,
>>
>> Here is the pull request for-next so that the series gets wider testing
>> to catch any regression early in the cycle.
> 
> This unfortunately adds a new warning to all the ARM builds:
> 
> mm/nobootmem.c: In function '__free_pages_memory':
> mm/nobootmem.c:88:201: warning: comparison of distinct pointer types lacks a cast
> 
I actually sent fix for it before sending you the pull request. Forgot
to capture that in message.

Patch[1] is already acked by Tejun and I was assuming it would
have been applied and should start showing up in next. Not sure
if its good idea but we could add the patch along with the $subject
series.

Regards,
Santosh

[1] https://lkml.org/lkml/2013/11/25/455
