From: richard.zhao@freescale.com (Richard Zhao)
Date: Tue, 22 May 2012 12:36:01 +0800
Subject: [PATCH v2 03/12] usb: ehci-hcd: notify phy when connect change
In-Reply-To: <201205220623.49878.marex@denx.de>
References: <1337592237-5090-1-git-send-email-richard.zhao@freescale.com>
 <1337592237-5090-4-git-send-email-richard.zhao@freescale.com>
 <201205220623.49878.marex@denx.de>
Message-ID: <20120522043600.GK6206@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Tue, May 22, 2012 at 06:23:49AM +0200, Marek Vasut wrote:
> Dear Richard Zhao,
> 
> > It still has below limitations:
> > - it does not work for multi-phy ehci
> > - the best place is after debounce, but I can't get
> >   phy there
> 
> Now, you'll laugh as this would be an obviously stupid question -- but where 
> exactly does the debounce happen in the code?
I meant hub_port_debounce function at drivers/usb/core/hub.c.

Thanks
Richard
