From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 12 Apr 2017 09:06:02 +0100
Subject: [linux-sunxi] Re: [PATCH v2 03/11] dt-bindings: add device tree
 binding for X-Powers AXP803 PMIC
In-Reply-To: <20170411180844.9176B125521@relay.mailchannels.net>
References: <20170411180844.9176B125521@relay.mailchannels.net>
Message-ID: <20170412080602.f7cjeeht5r45cnvh@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 12 Apr 2017, Icenowy Zheng wrote:

> 
> 2017?4?12? ??12:29? Lee Jones <lee.jones@linaro.org>???
> >
> > On Tue, 11 Apr 2017, Chen-Yu Tsai wrote:
> >
> > > Hi,
> > > 
> > > On Tue, Apr 11, 2017 at 11:00 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> > > >
> > > >
> > > > On Tue, 11 Apr 2017, Lee Jones wrote:
> > > >
> > > >> On Sat, 08 Apr 2017, Icenowy Zheng wrote:
> > > >>
> > > >>> AXP803 is a PMIC produced by Shenzhen X-Powers, with either I2C or RSB
> > > >>> bus.
> > > >>>
> > > >>> Add a compatible for it.
> > > >>>
> > > >>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > > >>> Acked-by: Chen-Yu Tsai <wens@csie.org>
> > > >>> ---
> > > >>> Changes in v2:
> > > >>> - Place AXP803 before AXP806/809.
> > > >>> - Added Chen-Yu's ACK.
> > > >>>
> > > >>>? Documentation/devicetree/bindings/mfd/axp20x.txt | 5 +++--
> > > >>>? 1 file changed, 3 insertions(+), 2 deletions(-)
> > > >>
> > > >>
> > > >> For my own reference:
> > > >>? Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > > >
> > > >
> > > > Excuse me... Who will apply this patch?
> >
> > Excuse you?? Are you trying to be polite, or rude?
> >
> > I'm guessing due to the lagging '...', that it's the latter?
> 
> Oh sorry, I mean the former...

Okay, no problem then.

> > > > I think this patch should be applied by you as it's in bindings/mfd
> > > > directory, however, if I'm wrong, please point out ;-)
> > >
> > > We need the DT maintainers to ack it first. :)
> >
> > We don't really need the DT Maintainers to get involved here.
> >
> > What I do need is either clear direction as to how this
> > patch-set should be applied, or an indication of which patches are
> > dependant on others and which are orthogonal and can be applied
> > independently.
> 
> This patch is independent, although the regulator binding patch
> depends on it.
> 
> The real driver patches will need the binding patches to be merged
> first.

Right, so Acking and not applying wasn't such a strange practice
after all then. =;-)

> And the dt patches depend on also the binding patches.

The issue I have now is; because your email client replies as a new
mail i.e. non-threaded, now I have no reference to the patch-set.

Since time is a valuable resource, I will not be dredging though my
inbox looking for all your replies.

Please fix your client before replying to another mail.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
