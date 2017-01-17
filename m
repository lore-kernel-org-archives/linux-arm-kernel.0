From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 17 Jan 2017 21:51:19 +0100
Subject: [PATCH 1/2] dt-bindings: gpu: Add Mali Utgard bindings
In-Reply-To: <CAJKOXPdbbzoqNLg=iRGC8ijVPdpLD5+CFyqysfM49vkx6o3rRQ@mail.gmail.com>
References: <20170116132424.7038-1-maxime.ripard@free-electrons.com>
 <20170116184906.r62di7xiil5lae33@kozik-lap>
 <20170117093813.mxp2hgoxbgske6ru@lukather>
 <CAJKOXPdbbzoqNLg=iRGC8ijVPdpLD5+CFyqysfM49vkx6o3rRQ@mail.gmail.com>
Message-ID: <20170117205119.5cb2qc5wclxd2a3v@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2017 at 01:31:19PM +0200, Krzysztof Kozlowski wrote:
> On Tue, Jan 17, 2017 at 11:38 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Hi,
> >
> > On Mon, Jan 16, 2017 at 08:49:06PM +0200, Krzysztof Kozlowski wrote:
> >> On Mon, Jan 16, 2017 at 02:24:23PM +0100, Maxime Ripard wrote:
> >> > The ARM Mali Utgard GPU family is embedded into a number of SoCs from
> >> > Allwinner, Amlogic, Mediatek or Rockchip.
> >> >
> >> > Add a binding for the GPU of that family.
> >> >
> >> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> >> > ---
> >> >  .../devicetree/bindings/gpu/arm,mali-utgard.txt    | 76 ++++++++++++++++++++++
> >> >  1 file changed, 76 insertions(+)
> >> >  create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
> >>
> >> Do you have a driver in kernel which will implement these bindings?
> >
> > No, but we have bindings for out-of-tree drivers already.
> >
> >> Defining them for out-of-tree driver does not bring any benefits
> >> (3rd party driver will not respect them anyway).
> >
> > You could see it the other way around too. The out-of-tree drivers
> > don't respect it at the moment because there's no binding to respect.
> 
> Indeed, that's a point. However valid only when the out-of-tree driver
> will respect them, for example do not break them on next release.

If you're talking about the default platform provided by ARM, you also
have the option of creating your own. That's what we did, and it
worked like a charm.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170117/9fc96800/attachment.sig>
