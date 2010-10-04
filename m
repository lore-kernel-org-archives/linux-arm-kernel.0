From: manjugk@ti.com (G, Manjunath Kondaiah)
Date: Tue, 5 Oct 2010 00:22:51 +0530
Subject: [PATCH v2] OMAP3: Keypad: Fix failure exit path in probe
In-Reply-To: <20101004182834.GE8321@core.coreip.homeip.net>
References: <1285069770-4261-1-git-send-email-manjugk@ti.com>
	<1285076060.14206.3.camel@chotu>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402785A3478@dbde02.ent.ti.com>
	<20100921162658.GA2310@core.coreip.homeip.net>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402DB90C98C@dbde02.ent.ti.com>
	<20101004182834.GE8321@core.coreip.homeip.net>
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90CD8A@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org




> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov at gmail.com] 
> Sent: Monday, October 04, 2010 11:59 PM
> To: G, Manjunath Kondaiah
> Cc: Ameya Palande; linux-omap at vger.kernel.org; 
> linux-input at vger.kernel.org; 
> linux-arm-kernel at lists.infradead.org; Tony Lindgren
> Subject: Re: [PATCH v2] OMAP3: Keypad: Fix failure exit path in probe
> 
> On Mon, Oct 04, 2010 at 01:32:29PM +0530, G, Manjunath Kondaiah wrote:
> > Dmitry,
> > As agreed, can you push this patch?
> > https://patchwork.kernel.org/patch/197442/
> > 
> 
> Manjunath,
> 
> It is queued for 2.6.37 (take a peek at 'next' branch of my 
> tree) - I do not believe that the failure is critical enough for .36.

Thanks for queuing this patch for 2.6.37

-Manjunath
