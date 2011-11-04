From: khilman@ti.com (Kevin Hilman)
Date: Fri, 04 Nov 2011 09:57:49 -0700
Subject: [PATCH v8 REPOST 21/24] gpio/omap: save and restore debounce
	registers
In-Reply-To: <1318422730-22282-1-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Wed, 12 Oct 2011 18:02:10 +0530")
References: <1318422730-22282-1-git-send-email-tarun.kanti@ti.com>
Message-ID: <87zkgbbzaq.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> From: Nishanth Menon <nm@ti.com>
>
> GPIO debounce registers need to be saved and restored for proper functioning
> of driver. 

OK.

> To save the registers, we cannot cut the clock before the save,
> hence move the clk disable after the save.

This patch doesn't move any clk disable.

I suspect you made some changes to the original patch from Nishanth.
Please note that in the changelog.  This is typically done by adding
something like:

[my at email.addr: describe changes made]

just before your signoff.

Kevin
