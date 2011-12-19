From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Dec 2011 09:15:06 +0000
Subject: [PATCH v3] ARM: mxs: Add initial support for Bluegiga APX4
 Development Kit
In-Reply-To: <20111219091322.GD14542@n2100.arm.linux.org.uk>
References: <1323766966-30502-1-git-send-email-lauri.hintsala@bluegiga.com>
 <20111219071350.GH4962@S2100-06.ap.freescale.net>
 <4EEEE40C.3000200@bluegiga.com>
 <20111219091916.GJ4962@S2100-06.ap.freescale.net>
 <20111219091322.GD14542@n2100.arm.linux.org.uk>
Message-ID: <20111219091506.GA16097@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 19, 2011 at 09:13:22AM +0000, Russell King - ARM Linux wrote:
> On Mon, Dec 19, 2011 at 05:19:17PM +0800, Shawn Guo wrote:
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

Also, whether Veli-Pekka Peltola is should still be the current owner
or whether there's someone more appropriate to be looking after this
entry (eg, the active platform maintainer) ?
