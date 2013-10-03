From: tony@atomide.com (Tony Lindgren)
Date: Wed, 2 Oct 2013 21:03:47 -0700
Subject: [PATCH v3 04/10] ARM: OMAP2+: usb-host: Adapt to USB phy-nop
 RESET line changes
In-Reply-To: <524BF354.3000502@ti.com>
References: <1380012836-29900-1-git-send-email-rogerq@ti.com>
 <1380012836-29900-5-git-send-email-rogerq@ti.com>
 <524BF354.3000502@ti.com>
Message-ID: <20131003040346.GI8949@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Roger Quadros <rogerq@ti.com> [131002 03:28]:
> Hi Tony,
> 
> On 09/24/2013 11:53 AM, Roger Quadros wrote:
> > The USB phy-nop nop driver expects the RESET line information
> > to be sent as a GPIO number via platform data. Adapt to that.
> > 
> > Signed-off-by: Roger Quadros <rogerq@ti.com>
> 
> Need your Ack on this one as well.

Acked-by: Tony Lindgren <tony@atomide.com>
