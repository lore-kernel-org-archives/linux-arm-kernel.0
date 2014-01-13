From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 13 Jan 2014 18:41:35 -0500
Subject: [PATCH] mm: nobootmem: avoid type warning about alignment value
In-Reply-To: <20140113233326.GG15937@n2100.arm.linux.org.uk>
References: <529217C7.6030304@cogentembedded.com> <52935762.1080409@ti.com>
 <20131209165044.cf7de2edb8f4205d5ac02ab0@linux-foundation.org>
 <20131210005454.GX4360@n2100.arm.linux.org.uk> <52A66826.7060204@ti.com>
 <20140112105958.GA9791@n2100.arm.linux.org.uk> <52D2B7C8.4060103@ti.com>
 <20140113123733.GU15937@n2100.arm.linux.org.uk> <52D3F7E0.3030206@ti.com>
 <20140113153128.6aaffb9af111ba75a7abd4db@linux-foundation.org>
 <20140113233326.GG15937@n2100.arm.linux.org.uk>
Message-ID: <52D479AF.3010302@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 13 January 2014 06:33 PM, Russell King - ARM Linux wrote:
> On Mon, Jan 13, 2014 at 03:31:28PM -0800, Andrew Morton wrote:
>> On Mon, 13 Jan 2014 09:27:44 -0500 Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:
>>
>>>> It seems to me to be absolutely silly to have code introduce a warning
>>>> yet push the fix for the warning via a completely different tree...
>>>>
>>> I mixed it up. Sorry. Some how I thought there was some other build
>>> configuration thrown the same warning with memblock series and hence
>>> suggested the patch to go via Andrew's tree.
>>
>> Yes, I too had assumed that the warning was caused by the bootmem
>> patches in -mm.
>>
>> But it in fact occurs in Linus's current tree.  I'll drop
>> mm-arm-fix-arms-__ffs-to-conform-to-avoid-warning-with-no_bootmem.patch
>> and I'll assume that rmk will fix this up at an appropriate time.
> 
> Thanks.  I'll apply my version and then I can pull Santosh's nobootmem
> changes (which I've had a couple of times already) without adding to
> the warnings.
> 
Thanks Andrew and Russell for sorting out the patch queue.

Regards,
Santosh
