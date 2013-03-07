From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 7 Mar 2013 10:48:21 +0800
Subject: [PATCH v11 9/9] usb: chipidea: udc: fix the oops when plugs in
 usb cable after rmmod gadget
In-Reply-To: <20130306184621.GX17833@n2100.arm.linux.org.uk>
References: <1362563800-16673-1-git-send-email-peter.chen@freescale.com>
 <1362563800-16673-10-git-send-email-peter.chen@freescale.com>
 <20130306184621.GX17833@n2100.arm.linux.org.uk>
Message-ID: <20130307024821.GE20470@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 06, 2013 at 06:46:21PM +0000, Russell King - ARM Linux wrote:
> On Wed, Mar 06, 2013 at 05:56:40PM +0800, Peter Chen wrote:
> > root at freescale ~$ ci_hdrc ci_hdrc.0: Connected to host
> > Unable to handle kernel paging request at virtual address 7f01171c
> > pgd = 80004000
> > [7f01171c] *pgd=4fa1e811, *pte=00000000, *ppte=00000000
> > Internal error: Oops: 7 [#1] SMP ARM
> > Modules linked in: f_acm libcomposite u_serial [last unloaded: g_serial]
> > CPU: 0    Not tainted  (3.8.0-rc5+ #221)
> > 	PC is at _gadget_stop_activity+0xbc/0x128
> > 	LR is at ep_fifo_flush+0x68/0xa0
> 
> 
> Why much of the oops dump indented?
> 

Maybe it occurs when I paste it, I will change it.
Thanks.

-- 

Best Regards,
Peter Chen
