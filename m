From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 9 Sep 2014 18:01:36 +0200
Subject: [PATCH v2 3/8] Documentation: bindings: net: add the Marvell
 PXA168 Ethernet controller
In-Reply-To: <3827594.chb831jyvc@wuerfel>
References: <1410273848-24663-1-git-send-email-antoine.tenart@free-electrons.com>
 <1410273848-24663-4-git-send-email-antoine.tenart@free-electrons.com>
 <3827594.chb831jyvc@wuerfel>
Message-ID: <20140909160136.GA26051@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

On Tue, Sep 09, 2014 at 05:58:12PM +0200, Arnd Bergmann wrote:
> On Tuesday 09 September 2014 16:44:03 Antoine Tenart wrote:
> > +- clocks: pointer to the clock for the device.
> > +- clock-names: should be "MFUCLK".
> 
> Clock names are normally not capitalized. Are you able to change
> that name when providing a binding or make it an anoymous clock?
> What does MFU stand for anyway?

Sure. I could have make it an anonymous clock but the name "MFUCLK" was
already used by the pxa168 Ethernet driver so I didn't wanted to change
that.

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
