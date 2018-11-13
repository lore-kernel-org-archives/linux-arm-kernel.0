From: peron.clem@gmail.com (=?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?=)
Date: Tue, 13 Nov 2018 15:59:09 +0100
Subject: [PATCH] ARM: dts: i.MX25: add the clocks for the EPIT blocks
In-Reply-To: <20181113144209.GB4557@dragon>
References: <1541093567-29205-1-git-send-email-martin@kaiser.cx>
 <20181104144614.GJ26016@tiger>
 <20181105091230.z2ooz7olbdpopxyd@viti.kaiser.cx>
 <20181113144209.GB4557@dragon>
Message-ID: <CAJiuCcc1dh9CYO1QcTUOfUPZdjZng80GX=0PiX+cQQ-m4=vq_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Tue, 13 Nov 2018 at 15:42, Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Mon, Nov 05, 2018 at 10:12:30AM +0100, Martin Kaiser wrote:
> > Hi,
> >
> > Thus wrote Shawn Guo (shawnguo at kernel.org):
> >
> > > On Thu, Nov 01, 2018 at 06:32:47PM +0100, Martin Kaiser wrote:
> > > > The i.MX25 contains two EPIT (Enhanced Periodic Interrupt Timer)
> > > > function blocks. Add their ipg and per clocks to the device tree.
> >
> > > > Signed-off-by: Martin Kaiser <martin@kaiser.cx>
Acked-by: Cl?ment P?ron <peron.clem@gmail.com>
> >
> > > Are these EPIT devices actually used in upstream kernel, or just
> > > somewhere else?
> >
> > Until I saw Vladimir's mail this morning, I wasn't aware of any mainline
> > driver that's using the EPIT devices. I found that the clocks are
> > missing when I tried to use EPIT with a company-internal driver that's
> > not suitable for mainline integration.
> >
> > Still, I think that merging this patch does no harm. If the EPIT devices
> > are present in the DT, we should add all resources they're using.
>
> Agreed.  I will be happy to apply the patch if I can get an ACK from
> Cl?ment saying this works with his driver in upstreaming.

I have paused the dev of this driver for now, but this is fine for me.

Regards,
Clement

>
> Shawn
