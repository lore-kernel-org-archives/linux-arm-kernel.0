From: jon.mason@broadcom.com (Jon Mason)
Date: Tue, 1 Nov 2016 16:59:14 -0400
Subject: [PATCH v4 2/7] Documentation: devicetree: add PHY lane swap
 binding
In-Reply-To: <20161101204826.GA21010@lunn.ch>
References: <1478030682-27012-1-git-send-email-jon.mason@broadcom.com>
 <1478030682-27012-3-git-send-email-jon.mason@broadcom.com>
 <20161101204826.GA21010@lunn.ch>
Message-ID: <20161101205913.GA27191@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 01, 2016 at 09:48:26PM +0100, Andrew Lunn wrote:
> > +- enet-phy-lane-swap: If set, indicates the PHY device requires swapping the
> > +  TX/RX lanes to function properly.
> 
> Is 'requires' the right word here? The PHY performs the actual swap of
> the Tx/Rx lanes.

What I'm trying to say here is that without the lane swapping, the PHY
will not function properly.  Thus, those PHYs require this parameter
to work.  I am open to suggestions to reword the sentence to make it
clearer.

Thanks,
Jon

> 
>     Andrew
