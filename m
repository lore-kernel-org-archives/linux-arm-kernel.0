From: olof@lixom.net (Olof Johansson)
Date: Mon, 14 Jan 2013 10:16:05 -0800
Subject: [PATCH v2 0/3] Use helper clockevents_config_and_register()
In-Reply-To: <alpine.LFD.2.02.1301141222130.7475@ionos>
References: <1357991406-22778-1-git-send-email-shawn.guo@linaro.org>
 <201301122114.07278.arnd@arndb.de>
 <alpine.LFD.2.02.1301141222130.7475@ionos>
Message-ID: <20130114181605.GB31901@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 14, 2013 at 12:23:16PM +0100, Thomas Gleixner wrote:
> On Sat, 12 Jan 2013, Arnd Bergmann wrote:
> > On Saturday 12 January 2013, Shawn Guo wrote:
> > > The clockevent core is able to figure out the best mult and shift,
> > > calculate min_delta_ns and max_delta_ns, with the necessary info passed
> > > into clockevents_config_and_register().  Use this handy helper to make
> > > the drivers less error prone and save some LOC.
> > > 
> > > Changes since v1:
> > >  - Add one patch to export clockevents_config_and_register for fixing
> > >    the error [1] reported by Fengguang.
> > >  - Add Acked-by and Tested-by tags given by people (Thanks!)
> > > 
> > > [1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/209152
> > 
> > Very nice series!
> > 
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> 
> Arnd, can you take the whole lot via the ARM tree? The export should
> not cause any conflicts, and if it does Linus should be able to solve
> it :)

(with the presumed s/Arnd/Arnd or Olof/)

Great! I've applied these to a clockevent/cleanup topic branch in arm-soc,
together with the added acks, etc.


-Olof
