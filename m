From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 10 Jan 2010 12:26:17 +0000
Subject: [PATCH] serial21285: fix disable_irq-from-interrupt-handler
	deadlock
In-Reply-To: <20091217085142.18e95993@marrow.netinsight.se>
References: <20091113090234.7d028820@marrow.netinsight.se>
	<20091113095937.GA25995@n2100.arm.linux.org.uk>
	<20091217085142.18e95993@marrow.netinsight.se>
Message-ID: <20100110122616.GA6914@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 17, 2009 at 08:51:42AM +0100, Simon Kagstrom wrote:
> Hi again Russell!
> 
> On Fri, 13 Nov 2009 09:59:37 +0000
> Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> 
> > On Fri, Nov 13, 2009 at 09:02:34AM +0100, Simon Kagstrom wrote:
> > > Russell: This patch is a bit of RFC since I'm not quite sure that it's
> > > the correct solution. It unbreaks booting on our footbridge-based
> > > platform. Let me know if I should look at other solutions!
> > 
> > It does look like the right thing to do - the original code will hang
> > now that we're using genirq stuff.
> 
> I haven't see this patch in 2.6.33 yet, was it forgotten or is it still
> in the queue somewhere?
> 
> (Ping!)

It needs to go into the patch system; I'm terrible with taking patches
directly from email.

Just add a 'KernelVersion:' tag to indicate which version the patch was
generated against somewhere in the patch description and forward to
patches at arm.linux.org.uk
