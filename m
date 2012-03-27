From: tony@atomide.com (Tony Lindgren)
Date: Tue, 27 Mar 2012 10:04:45 -0700
Subject: [GIT PULL] ARM: OMAP2+: PM: core support for SMPS regulators
 for v3.4
In-Reply-To: <CANOLnOMfsdGn-B0zftcV-zh+tSCGgmf0g1BsrFB0+Kh-HnNq0g@mail.gmail.com>
References: <20120308021843.GQ12083@atomide.com> <87399jc6cj.fsf@ti.com>
 <20120309003217.GB12083@atomide.com>
 <20120309114731.GA3273@opensource.wolfsonmicro.com>
 <87zkbp4wtj.fsf@ti.com>
 <20120311204232.GC3171@opensource.wolfsonmicro.com>
 <87399dzq5e.fsf@ti.com>
 <20120312173215.GL3110@opensource.wolfsonmicro.com>
 <87pqchv1pc.fsf@ti.com>
 <CANOLnOMfsdGn-B0zftcV-zh+tSCGgmf0g1BsrFB0+Kh-HnNq0g@mail.gmail.com>
Message-ID: <20120327170445.GP9859@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Grazvydas Ignotas <notasas@gmail.com> [120327 07:00]:
> On Tue, Mar 13, 2012 at 1:28 AM, Kevin Hilman <khilman@ti.com> wrote:
> > Tony, updated pull request below. ?This includes all the TWL depencies
> > merged from the 'topic/twl' tag in Mark's tree.
> >
> 
> Has this been lost now? It seems regulator parts got merged, but
> voltage parts are missing from Arnd's pull requests and are not
> showing up in linux-next.
> Was looking forward for voltage control in 3.4 to achieve higher clock
> rates on our aging OMAP3 hardware.

Sounds like this is something we should get merged early to arm-soc
tree after the merge window.

Regards,

Tony
