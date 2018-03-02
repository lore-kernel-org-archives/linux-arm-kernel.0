From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Fri, 2 Mar 2018 17:09:01 +0300
Subject: [PATCH] i2c: s3c2410: Properly handle interrupts of number 0
In-Reply-To: <20180302135854.76ue5jzsg7lvxjxw@katana>
References: <1519936484-23132-1-git-send-email-krzk@kernel.org>
 <20180302111931.GX9418@n2100.armlinux.org.uk>
 <20180302124647.sfhnto77wgdh5sv6@katana>
 <20180302125907.GA9418@n2100.armlinux.org.uk>
 <20180302135854.76ue5jzsg7lvxjxw@katana>
Message-ID: <20180302140901.lrjqiaa2k4nxkqco@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 02, 2018 at 02:58:54PM +0100, Wolfram Sang wrote:
> 
> > It needs platform maintainers to be motivated to fix it, and one way to
> > provide that motivation is for subsystem maintainers to say no to patches
> > like this.  If patches like this get accepted, then the "problem" gets
> > solved, and there is very little motivation to fix the platform itself.
> 
> Yes, I can see this. I will drop / revert the patch.
> 

TBH, I can't find the threads from November so I feel a bit lost and
there is no documentation for platform_get_irq().

regards,
dan carpenter
