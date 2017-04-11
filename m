From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 11 Apr 2017 17:29:06 +0100
Subject: [linux-sunxi] Re: [PATCH v2 03/11] dt-bindings: add device tree
 binding for X-Powers AXP803 PMIC
In-Reply-To: <CAGb2v65UiFqjYES3hF-S6THZ5Xu-HRS9R7Ngk8xeP1rZajsr7w@mail.gmail.com>
References: <20170407183441.58750-1-icenowy@aosc.io>
 <20170407183441.58750-4-icenowy@aosc.io>
 <20170411140427.doq5atxk6ptjrp36@dell>
 <alpine.LNX.2.20.1704112237290.39759@x220i>
 <CAGb2v65UiFqjYES3hF-S6THZ5Xu-HRS9R7Ngk8xeP1rZajsr7w@mail.gmail.com>
Message-ID: <20170411162906.mz2tuwyji4gtw4pa@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 11 Apr 2017, Chen-Yu Tsai wrote:

> Hi,
> 
> On Tue, Apr 11, 2017 at 11:00 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> >
> >
> > On Tue, 11 Apr 2017, Lee Jones wrote:
> >
> >> On Sat, 08 Apr 2017, Icenowy Zheng wrote:
> >>
> >>> AXP803 is a PMIC produced by Shenzhen X-Powers, with either I2C or RSB
> >>> bus.
> >>>
> >>> Add a compatible for it.
> >>>
> >>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> >>> Acked-by: Chen-Yu Tsai <wens@csie.org>
> >>> ---
> >>> Changes in v2:
> >>> - Place AXP803 before AXP806/809.
> >>> - Added Chen-Yu's ACK.
> >>>
> >>>  Documentation/devicetree/bindings/mfd/axp20x.txt | 5 +++--
> >>>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>
> >>
> >> For my own reference:
> >>  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> >
> >
> > Excuse me... Who will apply this patch?

Excuse you?  Are you trying to be polite, or rude?

I'm guessing due to the lagging '...', that it's the latter?

> > I think this patch should be applied by you as it's in bindings/mfd
> > directory, however, if I'm wrong, please point out ;-)
>
> We need the DT maintainers to ack it first. :)

We don't really need the DT Maintainers to get involved here.

What I do need is either clear direction as to how this
patch-set should be applied, or an indication of which patches are
dependant on others and which are orthogonal and can be applied
independently.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
