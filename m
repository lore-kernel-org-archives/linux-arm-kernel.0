From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 4 Jan 2012 21:52:05 +0800
Subject: [PATCH v3] ARM: mxs: Add initial support for Bluegiga APX4
 Development Kit
In-Reply-To: <20111219091322.GD14542@n2100.arm.linux.org.uk>
References: <1323766966-30502-1-git-send-email-lauri.hintsala@bluegiga.com>
 <20111219071350.GH4962@S2100-06.ap.freescale.net>
 <4EEEE40C.3000200@bluegiga.com>
 <20111219091916.GJ4962@S2100-06.ap.freescale.net>
 <20111219091322.GD14542@n2100.arm.linux.org.uk>
Message-ID: <20120104135204.GA14741@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 19, 2011 at 09:13:22AM +0000, Russell King - ARM Linux wrote:
> On Mon, Dec 19, 2011 at 05:19:17PM +0800, Shawn Guo wrote:
> > On Mon, Dec 19, 2011 at 09:13:16AM +0200, Lauri Hintsala wrote:
> > > On 12/19/2011 09:13 AM, Shawn Guo wrote:
> > > >The patch looks good.
> > > 
> > > Thank you for your time.
> > > 
> > > 
> > > >The only problem I have is I do not see MACH_TYPE_APX4DEVKIT defined
> > > >in arch/arm/tools/mach-types on either Linus' tree or linux-next
> > > >tree.  I'm afraid that we will experience the same problem we have
> > > >experienced with m28evk patch, which broke the whole mxs build for a
> > > >couple of early -rc of v3.2.
> > > 
> > > I see the problem. What is your suggestion? Should we create patch
> > > to add APX4DEVKIT to mach-types file as you did last time?
> > > http://permalink.gmane.org/gmane.linux.ports.arm.kernel/140425
> > > 
> > > We have register apx4devkit to ARM machine database. Machine id of
> > > apx4devkit is 3712. For some reason "Kconfig macro" and "type
> > > identifier" are out of sync in db. DEVKIT string is missing from
> > > those.
> > > http://www.arm.linux.org.uk/developer/machines/list.php?id=3712
> > > 
> > Hi Russell,
> > 
> > We have seen APX4DEVKIT in the ARM machine database.  But you did not
> > include it in the commit aef1c03 (ARM: Update mach-types) which is
> > sitting on -next.  Can you please include it as we plan to merge the
> > board support during the coming merge window?
> 
> No.  It will be automatically removed from any update as long as it does
> not conform to the requirements - that is, in this case, the strings
> being out of sync indentified in the message to which you replied to.
> 
> Someone needs to tell me what the correct entry is supposed to look like.
> 
Hi Russell,

Any chance to have APX4DEVKIT included in your patch 'ARM: Update
mach-types' for 3.3?

-- 
Regards,
Shawn
