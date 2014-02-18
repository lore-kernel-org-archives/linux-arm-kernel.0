From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 18 Feb 2014 11:02:26 -0500
Subject: irqchip: irq-dove: problem with the PMU interrupt controller.
In-Reply-To: <20140218102125.5bfe268d@armhf>
References: <20140209091016.26a59d44@armhf> <20140209082247.GD29203@lunn.ch>
 <20140217201334.GZ7862@titan.lakedaemon.net>
 <20140218102125.5bfe268d@armhf>
Message-ID: <20140218160226.GS7862@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 10:21:25AM +0100, Jean-Francois Moine wrote:
> On Mon, 17 Feb 2014 15:13:34 -0500
> Jason Cooper <jason@lakedaemon.net> wrote:
> 
> > Unfortunately, this didn't happen.  I've posted a patch to revert adding
> > the DT node for v3.14.  It'll be re-added in conjunction with the driver
> > code.  Hopefully for v3.15.
> > 
> >   http://www.spinics.net/lists/arm-kernel/msg308413.html
> > 
> > Please test and let me know if that fixes the WARN_ON.
> 
> That works for me. Thanks.

Unless you object, I'll count this as a Tested-by:

thx,

Jason.
