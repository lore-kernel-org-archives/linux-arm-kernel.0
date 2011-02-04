From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 4 Feb 2011 16:16:07 +0530
Subject: [PATCH 4/5] ARM: scu: Move register defines to header file
In-Reply-To: <20110204104113.GD15004@n2100.arm.linux.org.uk>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com>
	<1295859080-15259-5-git-send-email-santosh.shilimkar@ti.com>
	<20110125114635.GB13300@n2100.arm.linux.org.uk>
	<236d45e400a960cc3b32db538b3a79ae@mail.gmail.com>
	<20110125121655.GD13300@n2100.arm.linux.org.uk>
	<4534e82bf14eeea9f96769df760df5ae@mail.gmail.com>
	<20110125125656.GG13300@n2100.arm.linux.org.uk>
	<20110125130422.GH13300@n2100.arm.linux.org.uk>
	<20110125130611.GA15663@n2100.arm.linux.org.uk>
	<627ff975140c8e4afbad281105b29d35@mail.gmail.com>
	<20110204104113.GD15004@n2100.arm.linux.org.uk>
Message-ID: <c703383234131695d040a1e5b8a79413@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Friday, February 04, 2011 4:11 PM
> To: Santosh Shilimkar
> Cc: catalin.marinas at arm.com; linus.ml.walleij at gmail.com; linux-
> omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> ccross at android.com
> Subject: Re: [PATCH 4/5] ARM: scu: Move register defines to header
> file
>
> On Tue, Jan 25, 2011 at 11:53:35PM +0530, Santosh Shilimkar wrote:
> > After fixing the 3rd version for base address break, I was able to
> > use this patch and test it. Seems to work. SMC related stuff can
> > be ignored because OMAP4 ES1.0 doesn't have functional PM hardware
> > support.
>
> I think I'd prefer to do as the other functions do, and pass in the
> scu base address from the platform code.  It's potentially more
> efficient for platforms which have a fixed SCU base address.
Ok. I can fix that
