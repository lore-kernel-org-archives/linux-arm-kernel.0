From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 4 Jan 2012 21:18:00 +0000
Subject: [PATCH v3] ARM: mxs: Add initial support for Bluegiga APX4
 Development Kit
In-Reply-To: <20120104135204.GA14741@S2100-06.ap.freescale.net>
References: <1323766966-30502-1-git-send-email-lauri.hintsala@bluegiga.com>
 <20111219071350.GH4962@S2100-06.ap.freescale.net>
 <4EEEE40C.3000200@bluegiga.com>
 <20111219091916.GJ4962@S2100-06.ap.freescale.net>
 <20111219091322.GD14542@n2100.arm.linux.org.uk>
 <20120104135204.GA14741@S2100-06.ap.freescale.net>
Message-ID: <20120104211800.GF11810@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 04, 2012 at 09:52:05PM +0800, Shawn Guo wrote:
> On Mon, Dec 19, 2011 at 09:13:22AM +0000, Russell King - ARM Linux wrote:
> > No.  It will be automatically removed from any update as long as it does
> > not conform to the requirements - that is, in this case, the strings
> > being out of sync indentified in the message to which you replied to.
> > 
> > Someone needs to tell me what the correct entry is supposed to look like.
> > 
> Hi Russell,
> 
> Any chance to have APX4DEVKIT included in your patch 'ARM: Update
> mach-types' for 3.3?

As it appears when I run the update script, the answer is yes.  I'll
update the commit in the next couple of days (I want to reduce the
number of times I re-merge the tree now that I've a git-rerere immune
conflict to deal with.)
