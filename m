From: jacopo@jmondi.org (jmondi)
Date: Thu, 6 Apr 2017 16:31:20 +0200
Subject: [PATCH] arm64: dts: r8a7795: salvator-x: Add current sense
 amplifiers
In-Reply-To: <20170328121633.GA20146@verge.net.au>
References: <1490694282-9439-1-git-send-email-geert+renesas@glider.be>
 <20170328121633.GA20146@verge.net.au>
Message-ID: <20170406143120.GA22962@w540>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert, Simon,

On Tue, Mar 28, 2017 at 02:16:38PM +0200, Simon Horman wrote:
> On Tue, Mar 28, 2017 at 11:44:42AM +0200, Geert Uytterhoeven wrote:
> > Add device nodes for two Maxim max961x current sense amplifiers
> > sensing the VDD_0.8V and DVFS_0.8V lines.
> >
> > Based on a patch for r8a7796-salvator-x.dts by Jacopo Mondi.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > Pending acceptance of the maxim,max9611 DT bindings.
>
> I have marked this as deferred accordingly.

Just to point out that in v5 I just sent out, bindings are different
and this patch needs an update.

Thanks
  j
