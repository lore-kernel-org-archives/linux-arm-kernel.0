From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 2 Apr 2013 22:49:19 -0400
Subject: [PATCH v3] ARM: dove: add more hardware description in the DT
In-Reply-To: <20130330221212.GC13280@titan.lakedaemon.net>
References: <20130326080719.2d4d6450@armhf>
 <20130330221212.GC13280@titan.lakedaemon.net>
Message-ID: <20130403024919.GU13280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 30, 2013 at 06:12:12PM -0400, Jason Cooper wrote:
> On Tue, Mar 26, 2013 at 08:07:19AM +0100, Jean-Francois Moine wrote:
> > The 88AP510 chip (Marvell Dove) contains a LCD controller, a display
> > controller and two audio controllers.
> > 
> > Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> > ---
> > v3 from Sebastian Hesselbarth remarks
> >    - dcon register block ends at 0xc4
> > v2 from Sebastian Hesselbarth remarks
> >    - better names for the devices
> >    - fix bad i2s interrupt controller
> >    - 2 irq's by audio controller
> >    - display controller added
> > ---
> >  arch/arm/boot/dts/dove.dtsi |   38 +++++++++++++++++++++++++++++++
> >  1 file changed, 38 insertions(+)
> 
> Applied to mvebu/dt

I've dropped this version from mvebu/dt until you and Sebastian work it
out.

thx,

Jason.
