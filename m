From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 12 May 2014 11:48:38 -0300
Subject: [PATCH] irqchip: armada-370-xp: Move the devicetree binding
 documentation
In-Reply-To: <20140512163642.0cac3359@free-electrons.com>
References: <1399904860-937-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140512163642.0cac3359@free-electrons.com>
Message-ID: <20140512144838.GA2689@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 May 04:36 PM, Thomas Petazzoni wrote:
> On Mon, 12 May 2014 11:27:40 -0300, Ezequiel Garcia wrote:
> > Move the devicetree binding documentation to the interrupt-controller
> > directory, where it belongs.
> > 
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > ---
> >  .../devicetree/bindings/arm/armada-370-xp-mpic.txt | 38 ----------------------
> >  .../marvell,armada-370-xp-mpic.txt                 | 38 ++++++++++++++++++++++
> >  2 files changed, 38 insertions(+), 38 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/arm/armada-370-xp-mpic.txt
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/marvell,armada-370-xp-mpic.txt
> 
> Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Thanks for reviewing!

Ouch, before anyone complains, I've just realised I forgot to create the patch
with the rename detection flag :-(
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
