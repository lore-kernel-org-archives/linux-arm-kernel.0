From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 17 Jan 2013 11:50:26 +0530
Subject: [PATCH] ARM: mm: Fix missing XN flag for for MT_MEMORY_SO
In-Reply-To: <20130116231631.GW23505@n2100.arm.linux.org.uk>
References: <1358347762-14682-1-git-send-email-santosh.shilimkar@ti.com>
 <20130116231631.GW23505@n2100.arm.linux.org.uk>
Message-ID: <50F7982A.9010104@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 January 2013 04:46 AM, Russell King - ARM Linux wrote:
> On Wed, Jan 16, 2013 at 08:19:22PM +0530, Santosh Shilimkar wrote:
>> Commit 8fb54284ba6a {ARM: mm: Add strongly ordered descriptor support}
>> added XN flag at section level but missed it at PTE level.
>>
>> Fix it by adding the L_PTE_XN to MT_MEMORY_SO PET descriptor.
>>
>> Cc: Russell King <linux@arm.linux.org.uk>
>>
>> Reported-by: Richard Woodruff <r-woodruff2@ti.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
>
> Hmm, yes. => patch system please.
>
7629/1 in patch system.

Regards,
Santosh
