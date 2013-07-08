From: tony@atomide.com (Tony Lindgren)
Date: Mon, 8 Jul 2013 04:54:06 -0700
Subject: [PATCH RFC 2/9] ARM: debug: clean up low level kernel
 debugging selection
In-Reply-To: <E1UvoLJ-0006He-RH@rmk-PC.arm.linux.org.uk>
References: <20130707124326.GP24642@n2100.arm.linux.org.uk>
 <E1UvoLJ-0006He-RH@rmk-PC.arm.linux.org.uk>
Message-ID: <20130708115406.GV5523@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King <rmk+kernel@arm.linux.org.uk> [130707 05:57]:
> It is silly to bury UART selection under multiple levels of choice
> statements, where the top level choice statement will only list
> about four entries when a single SoC is selected.  Move the UART
> selection up into the top level choice statement as it was always
> intended to be.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Nice, works for me:

Acked-by: Tony Lindgren <tony@atomide.com>
