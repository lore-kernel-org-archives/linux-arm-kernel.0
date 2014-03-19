From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 19 Mar 2014 13:41:26 +0100 (CET)
Subject: [PATCH v6 0/3] ARM: sun7i/sun6i: irqchip: Irqchip driver for
 NMI controller
In-Reply-To: <20140319123241.GI27873@lukather>
References: <1394890861-18347-1-git-send-email-carlo@caione.org>
 <alpine.DEB.2.02.1403191213240.18573@ionos.tec.linutronix.de>
 <20140319123241.GI27873@lukather>
Message-ID: <alpine.DEB.2.02.1403191341070.18573@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 19 Mar 2014, Maxime Ripard wrote:

> On Wed, Mar 19, 2014 at 12:13:56PM +0100, Thomas Gleixner wrote:
> > On Sat, 15 Mar 2014, Carlo Caione wrote:
> > 
> > > Allwinner A20/A31 SoCs have a special interrupt controller for managing NMI.
> > > Three register are present to (un)mask, control and acknowledge NMI.
> > > These two patches add a new irqchip driver in cascade with GIC.
> > 
> > If I get an ack for the DT parts, I'll pick it up.
> 
> I had some comments on it, so Carlo will probably resubmit it.

That's the resubmit as far as I can tell.
