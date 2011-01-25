From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 25 Jan 2011 12:16:56 +0000
Subject: [PATCH 4/5] ARM: scu: Move register defines to header file
In-Reply-To: <236d45e400a960cc3b32db538b3a79ae@mail.gmail.com>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com>
	<1295859080-15259-5-git-send-email-santosh.shilimkar@ti.com>
	<20110125114635.GB13300@n2100.arm.linux.org.uk>
	<236d45e400a960cc3b32db538b3a79ae@mail.gmail.com>
Message-ID: <20110125121655.GD13300@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 25, 2011 at 05:32:57PM +0530, Santosh Shilimkar wrote:
> I have similar patch implemented but what it does is just
> prepares the value to be programmed and stores it to a scratchpad.
> I see your point but below patch may now work well. The reason is the SCU
> register needs to accessed at the lowest level. May be even when
> stack is not available. Also this register needs to be cleared in cases
> where the attempted power state is failed for some reason.
