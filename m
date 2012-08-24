From: tony@atomide.com (Tony Lindgren)
Date: Fri, 24 Aug 2012 12:08:39 -0700
Subject: [PATCH v3 22/23] serial: omap: move uart_omap_port definition
 to C file
In-Reply-To: <1345717983-18179-23-git-send-email-balbi@ti.com>
References: <1345717983-18179-1-git-send-email-balbi@ti.com>
 <1345717983-18179-23-git-send-email-balbi@ti.com>
Message-ID: <20120824190839.GS11011@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [120823 03:38]:
> nobody needs to access the uart_omap_port structure
> other than omap-serial.c file. Let's move that
> structure definition to the C source file in order
> to prevent anyone from accessing our structure.
> 
> Tested-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> Signed-off-by: Felipe Balbi <balbi@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>
