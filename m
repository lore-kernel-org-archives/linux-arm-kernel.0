From: tony@atomide.com (Tony Lindgren)
Date: Fri, 12 Oct 2012 14:51:56 -0700
Subject: [RFT/PATCH] serial: omap: prevent resume if device is not
 suspended.
In-Reply-To: <87lifbwhwd.fsf@deeprootsystems.com>
References: <20120925092118.GJ31374@n2100.arm.linux.org.uk>
 <CAKdam57bpTJ94Gn=mKVw1Fm-76fVPp3DGjFuNu_HfesybM1hPg@mail.gmail.com>
 <87ipas2y4h.fsf@deeprootsystems.com>
 <alpine.DEB.2.00.1210111748010.5736@utopia.booyaka.com>
 <50784458.9080806@ti.com> <877gqv7imt.fsf@deeprootsystems.com>
 <20121012164202.GQ28061@n2100.arm.linux.org.uk>
 <877gqv4lmt.fsf@deeprootsystems.com>
 <20121012185426.GS28061@n2100.arm.linux.org.uk>
 <87lifbwhwd.fsf@deeprootsystems.com>
Message-ID: <20121012215156.GL30339@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@deeprootsystems.com> [121012 13:34]:
>
> I'm not conviced (yet) that a mismatch is the root cause.  Yes, that's
> what the author of $SUBJECT patch assumed and stated, but I'm not
> pursuaded.  
> 
> If it's an improperly configured mux issue, then the UART will break
> whenever the device is actually omap_device_enable'd, whether in the
> driver or in the bus layer.

I tried booting n800 here with CONFIG_OMAP_MUX disabled, and no
change. Serial console output stops right when the console initializes.

Regards,

Tony
