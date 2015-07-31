From: skarajga@visteon.com (Karajgaonkar, Saurabh (S.))
Date: Fri, 31 Jul 2015 05:06:07 +0000
Subject: [PATCH] drivers/usb/: Simplify return statements
In-Reply-To: <20150730162527.GL18246@saruman.tx.rr.com>
References: <20150730131337.GA2715@alcatraz>
 <20150730162527.GL18246@saruman.tx.rr.com>
Message-ID: <20150731050558.GA2481@alcatraz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sure, I'll do that. Just wanted to know whether I should split the patches and
send them in this same mail thread (may be something like [PATCH 01/04 V2])
or should I start new threads and send them separately to the respective maintainers.

Thanks and Regards,
Saurabh Karajgaonkar

On Thu, Jul 30, 2015 at 11:25:27AM -0500, Felipe Balbi wrote:
> On Thu, Jul 30, 2015 at 01:13:42PM +0000, Karajgaonkar, Saurabh (S.) wrote:
> > From: Saurabh Karajgaonkar <skarajga@visteon.com>
> > 
> > This patch is created using simple_return.cocci coccinelle script.
> > It replaces the redundant instances where variables are assigned
> > return value from functions and then used in return statements.
> > 
> > Signed-off-by: Saurabh Karajgaonkar <skarajga@visteon.com>
> 
> do you mind splitting this per-driver ? That makes it a lot easier for
> different maintainers to take their part. For example, I would take
> drivers/usb/phy/* and drivers/usb/musb/*
> 
> Alan Stern would handle drivers/usb/host/[uoe]hci*.[ch]
> 
> Mathias Nyman, driver/usb/host/xhci*.[ch]
> 
> and so on. Thanks
> 
> -- 
> balbi
