From: vikram.pandita@ti.com (Pandita, Vikram)
Date: Tue, 4 May 2010 23:03:47 +0530
Subject: [PATCH 02b/11] omap2/3: Fix DEBUG_LL for omap zoom2/3
In-Reply-To: <20100504005838.GF29604@atomide.com>
References: <20100430210216.GI29604@atomide.com>
	<87vdb8hc2d.fsf@deeprootsystems.com>
	<FCCFB4CDC6E5564B9182F639FC3560870304E80F5F@dbde02.ent.ti.com>
	<87y6g4d2ic.fsf@deeprootsystems.com>
	<20100430233002.GJ29604@atomide.com>
	<87sk6c8osn.fsf@deeprootsystems.com>
	<20100501013751.GL29604@atomide.com>
	<20100501015050.GM29604@atomide.com>
	<FCCFB4CDC6E5564B9182F639FC3560870304F5A672@dbde02.ent.ti.com>
	<20100504004001.GB29604@atomide.com>
	<20100504005838.GF29604@atomide.com>
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870304F5AC4F@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Tony

>-----Original Message-----
>From: Tony Lindgren [mailto:tony at atomide.com]
>Sent: Monday, May 03, 2010 7:59 PM
>To: Pandita, Vikram
>Cc: Kevin Hilman; linux-arm-kernel at lists.infradead.org; linux-
>omap at vger.kernel.org; Pais, Allen
>Subject: [PATCH 02b/11] omap2/3: Fix DEBUG_LL for omap zoom2/3
>
>And here's this patch one more time. Both 2a and 2b are needed
>for zoom debug uart to work.

Test 1:
Tested on Zoom3 with 02a and 02b applied. Enabled DEBUG_LL. 
Booted fine.

Test 2:
Applied Hack printk.patch (attached)
Booted fine and duplicate logs can be seen on console => printascii is working.

Ack-by: Vikram Pandita <vikram.pandita@ti.com>

>
>Regards,
>
>Tony
-------------- next part --------------
A non-text attachment was scrubbed...
Name: printk.patch
Type: application/octet-stream
Size: 570 bytes
Desc: printk.patch
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100504/023b8b66/attachment-0001.obj>
