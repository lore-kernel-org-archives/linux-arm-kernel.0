From: tony@atomide.com (Tony Lindgren)
Date: Mon, 3 May 2010 17:57:09 -0700
Subject: [PATCH 02a/11] omap: Use a memory address for storing the debug
	port info instead of UART1 scratchpad
In-Reply-To: <20100504004001.GB29604@atomide.com>
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
Message-ID: <20100504005709.GE29604@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's this patch one more time. I updated the comments
for what I think the new shortcomings are.

I also changed #define OMAP_UART_INFO (PHYS_OFFSET + 0x3ffc)
instead of 0x3ff8 as it's set as u32.

Regards,

Tony
