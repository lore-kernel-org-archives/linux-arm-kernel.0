From: tony@atomide.com (Tony Lindgren)
Date: Sun, 18 Oct 2009 17:24:16 -0700
Subject: [PATCH 08/14] omap: Use ioremap for omap4 L4 code
In-Reply-To: <20091017161947.GK12576@atomide.com>
References: <20091016233624.2463.26653.stgit@localhost>
	<20091016234138.2463.38350.stgit@localhost>
	<20091016234622.GH12576@atomide.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02BB37D7AA@dbde02.ent.ti.com>
	<20091017161947.GK12576@atomide.com>
Message-ID: <20091019002416.GM12576@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [091017 09:19]:
> * Shilimkar, Santosh <santosh.shilimkar@ti.com> [091017 03:49]:
> > Thanks Tony for this ioremap series!!
> > 
> > > -----Original Message-----
> > > From: Tony Lindgren [mailto:tony at atomide.com]
> > > Sent: Saturday, October 17, 2009 5:16 AM
> > > To: linux-arm-kernel at lists.infradead.org
> > > Cc: linux-omap at vger.kernel.org; Shilimkar, Santosh
> > > Subject: Re: [PATCH 08/14] omap: Use ioremap for omap4 L4 code
> > > 
> > > * Tony Lindgren <tony@atomide.com> [091016 16:42]:
> > > > Use ioremap for omap4 L4 code
> > > 
> > > Santosh, can you please check and ack this patch?
> > > 
> > > Especially some of the ioremap sizes may be wrong. Also, this one
> > > I cannot boot test, so it's just compile tested.
> > 
> > I have checked the patch and it looks all right except few typo. Also the scu_base is needed bit earlier. 

<snip>
 
> > Here is the patch on top of ioremap series which should fix above mentioned things. With below patch + two serial related patches the kernel boots on OMAP4430.
> 
> Great, will update. Thanks for taking the time to fix it!

Here's this one updated with Santosh's fix merged in.

Tony
