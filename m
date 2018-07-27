From: robh+dt@kernel.org (Rob Herring)
Date: Fri, 27 Jul 2018 10:50:34 -0600
Subject: [PATCH] of/platform: Initialise default DMA masks
In-Reply-To: <a5c6dd56-100a-e1cd-b4c4-2a30d8791ade@arm.com>
References: <9ffa7f2676c25adf39e85ec8114b26500b5680f6.1532699305.git.robin.murphy@arm.com>
 <20180727142054.GA29316@lst.de> <a5c6dd56-100a-e1cd-b4c4-2a30d8791ade@arm.com>
Message-ID: <CAL_JsqJCtzhcO8s59d=SPEtYpDWhCkKo99cQiuK987Y1Oqgb9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 27, 2018 at 8:18 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 27/07/18 15:20, Christoph Hellwig wrote:
> > On Fri, Jul 27, 2018 at 03:14:15PM +0100, Robin Murphy wrote:
> >> This shouldn't strictly depend on the changes currently queued in the
> >> dma-mapping tree, so should be OK to go through the DT tree in parallel.
> >> Ideally we'd fix all DMA-capable drivers to set their masks correctly,
> >> but in the short term everyone's going to get cross about -rc1 not
> >> booting...
> >
> > I'd prefer to pick this up through the dma-mapping tree, and in fact
> > move it before the bus_dma_mask changes just to keep a bisectable
> > tree.
>
> Sure, if Rob and Frank are OK with that I don't mind either way.

NP.

Acked-by: Rob Herring <robh@kernel.org>
