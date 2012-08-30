From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 30 Aug 2012 11:03:57 -0700
Subject: [PATCH v2] ARM: Build dtb files in all target
In-Reply-To: <20120830165224.GR19437@titan.lakedaemon.net>
References: <1346303687-7795-1-git-send-email-andrew@lunn.ch>
 <20120830165224.GR19437@titan.lakedaemon.net>
Message-ID: <20120830180357.GA2459@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 30, 2012 at 12:52:24PM -0400, Jason Cooper wrote:
> On Thu, Aug 30, 2012 at 07:14:47AM +0200, Andrew Lunn wrote:
> > Tools like kisskb are good at finding build regressions in the kernel
> > sources. However, regressions in the DT desscriptions are not found,
> > because generally these build systems don't build the DT binary blobs.
> > 
> > Extend the ARM all target to build all enabled DTB files.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> 
> Acked-by: Jason Cooper <jason@lakedaemon.net>
> 
> I've CC'd stable to see if they want to pick this up.  It does depend on
> having dtc built.  A patch already exists to build dtc on demand, but
> I'm not sure if it has made it into mainline yet.  It may be in
> Russell's queue.

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>
