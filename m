From: tony@atomide.com (Tony Lindgren)
Date: Fri, 24 Aug 2012 12:08:19 -0700
Subject: [PATCH v3 20/23] serial: omap: fix software flow control
In-Reply-To: <1345717983-18179-21-git-send-email-balbi@ti.com>
References: <1345717983-18179-1-git-send-email-balbi@ti.com>
 <1345717983-18179-21-git-send-email-balbi@ti.com>
Message-ID: <20120824190819.GR11011@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [120823 03:38]:
> From: Vikram Pandita <vikram.pandita@ti.com>
> 
> Software flow control register bits were not defined correctly.
> 
> Also clarify the IXON and IXOFF logic to reflect what userspace wants.
> 
> Cc: stable at vger.kernel.org
> Tested-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> Signed-off-by: Felipe Balbi <balbi@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>
