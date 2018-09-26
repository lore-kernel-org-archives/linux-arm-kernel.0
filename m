From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 26 Sep 2018 12:40:53 +0200
Subject: [PATCH v11 1/2] dt-bindings: media: Add Allwinner V3s Camera
 Sensor Interface (CSI)
In-Reply-To: <1568838.d8CnAYTeDB@avalon>
References: <1537951204-24672-1-git-send-email-yong.deng@magewell.com>
 <7197338.mhOH8fQaEM@avalon> <20180926103547.5ubb6xjkl7xngmfg@flea>
 <1568838.d8CnAYTeDB@avalon>
Message-ID: <20180926104053.ijhmvvsbju36j4d3@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 26, 2018 at 01:38:08PM +0300, Laurent Pinchart wrote:
> Hi Maxime,
> 
> On Wednesday, 26 September 2018 13:35:47 EEST maxime.ripard at bootlin.com wrote:
> > On Wed, Sep 26, 2018 at 01:19:34PM +0300, Laurent Pinchart wrote:
> > > > +Endpoint node properties for CSI1
> > > > +---------------------------------
> > > 
> > > Should you list the CSI0 properties as well ? As the driver in patch 2/2
> > > doesn't support the CSI-2 interface I assume you have left out CSI0 for
> > > now, but it should still be listed in the bindings. I'm fine with fixing
> > > this as a follow-up patch to avoid missing the v4.20 merge window, but if
> > > you end up resubmitting the series, could you please address the problem
> > > ?
> > 
> > That driver is not available, and the documentation isn't either, so
> > there's no easy way to tell which properties are going to be needed
> > before doing the actual work of reverse engineering it and writing a
> > driver for it. Unfortunately...
> 
> While DT bindings should be independent from driver implementations, I agree 
> it's difficult to develop good bindings without hardware documentation and 
> without at least one working driver implementation.
> 
> How about just explicitly stating that these bindings don't support CSI0 yet ?

Yep, that would work

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
