From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 18 May 2014 19:54:09 -0400
Subject: [PATCH] irqchip: armada-370-xp: Move the devicetree binding
 documentation
In-Reply-To: <20140518235148.GB630@arch.cereza>
References: <1399904860-937-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140512163642.0cac3359@free-electrons.com>
 <20140512144838.GA2689@arch.cereza>
 <20140518233757.GA630@arch.cereza>
 <20140518234034.GA27822@titan.lakedaemon.net>
 <20140518235148.GB630@arch.cereza>
Message-ID: <20140518235409.GB27822@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 18, 2014 at 08:51:48PM -0300, Ezequiel Garcia wrote:
> On 18 May 07:40 PM, Jason Cooper wrote:
> > On Sun, May 18, 2014 at 08:37:58PM -0300, Ezequiel Garcia wrote:
> > > On 12 May 11:48 AM, Ezequiel Garcia wrote:
> > > > On 12 May 04:36 PM, Thomas Petazzoni wrote:
> > > > > On Mon, 12 May 2014 11:27:40 -0300, Ezequiel Garcia wrote:
> > > > > > Move the devicetree binding documentation to the interrupt-controller
> > > > > > directory, where it belongs.
> > > > > > 
> > > > > > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > > > > > ---
> > > > > >  .../devicetree/bindings/arm/armada-370-xp-mpic.txt | 38 ----------------------
> > > > > >  .../marvell,armada-370-xp-mpic.txt                 | 38 ++++++++++++++++++++++
> > > > > >  2 files changed, 38 insertions(+), 38 deletions(-)
> > > > > >  delete mode 100644 Documentation/devicetree/bindings/arm/armada-370-xp-mpic.txt
> > > > > >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/marvell,armada-370-xp-mpic.txt
> > > > > 
> > > > > Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > > > 
> > > > Thanks for reviewing!
> > > > 
> > > > Ouch, before anyone complains, I've just realised I forgot to create the patch
> > > > with the rename detection flag :-(
> > > 
> > > Jason,
> > > 
> > > Would you take this?
> > 
> > Sure, my quick read of the above self-reply led me to believe there was
> > another version coming...
> > 
> 
> Actually, there was... and then thought maybe you didn't need it.
> 
> Want me send it? I can do that real quick.

Please do.

thx,

Jason.
