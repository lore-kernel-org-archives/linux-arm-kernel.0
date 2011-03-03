From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 3 Mar 2011 21:39:00 +0530
Subject: [PATCH 03/17] omap4: Export scu base address
In-Reply-To: <87lj0x6v70.fsf@ti.com>
References: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com><1298112158-28469-4-git-send-email-santosh.shilimkar@ti.com>
	<87lj0x6v70.fsf@ti.com>
Message-ID: <98068b5a2cff38b99d47f8527340ce11@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman at ti.com]
> Sent: Thursday, March 03, 2011 3:29 AM
> To: Santosh Shilimkar
> Cc: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 03/17] omap4: Export scu base address
>
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>
> > The scu base address needs to be accessed in cpu hotplug
> > for power management. Hence export the same
>
> As with previous patch, rather than export the base address itself,
> it should export a helper function to get the base address
>

I dropped this patch in favor of the exported helpers to
get base address.
