From: tony@atomide.com (Tony Lindgren)
Date: Fri, 2 Aug 2013 05:37:52 -0700
Subject: [Ksummit-2013-discuss] [ARM ATTEND] Describing complex,
 non-probable system topologies
In-Reply-To: <20130802115334.GN2465@mudshark.cambridge.arm.com>
References: <20130801183531.GB29831@mudshark.cambridge.arm.com>
 <20130801192730.GC9174@kroah.com>
 <20130802115334.GN2465@mudshark.cambridge.arm.com>
Message-ID: <20130802123752.GH7656@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Will Deacon <will.deacon@arm.com> [130802 05:00]:
> On Thu, Aug 01, 2013 at 08:27:30PM +0100, Greg KH wrote:
> > 
> > The driver core handles this really well, you just have to create new
> > busses, and don't rely on the "catch-all" platform_bus.
> 
> Agreed, it's time that we started to describe these non-probable buses as
> separate bus_types, with controller logic for configuring the bus itself
> (there are weird-and-wonderful ring-based designs on the horizon which can
> require a fair amount of setup).

Yes we somehow need hardware specific buses, but they should appear
generic to the device drivers without having to modify each device
driver using these buses for each bus.

Regards,

Tony
