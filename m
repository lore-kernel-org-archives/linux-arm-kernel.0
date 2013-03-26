From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Tue, 26 Mar 2013 14:01:39 +0100
Subject: [PATCH 1/3] ARM: zynq: read scu base from SoC
In-Reply-To: <CAHTX3dKW1R+MKYyyFVapOvFiW0-x4z0DEUpJmuxr4j4UEWpNfw@mail.gmail.com>
References: <1364043450-18700-1-git-send-email-s.trumtrar@pengutronix.de>
 <1364043450-18700-2-git-send-email-s.trumtrar@pengutronix.de>
 <CAHTX3dK30HZxJXcNjwVqgqW_Qqag=26PEFWra6r7H6JGnpPHXQ@mail.gmail.com>
 <20130325142533.GB27739@pengutronix.de>
 <CAHTX3d+619gU64e-fxi5PLmjnmO6kNEJN4o5tFbbxZ-ccw+HtQ@mail.gmail.com>
 <20130326110819.GA32647@pengutronix.de>
 <CAHTX3dKoPfY=qHzsiVkESkEyiWpCT4xkimRqFoQHmye66w_qEA@mail.gmail.com>
 <20130326124655.GB32647@pengutronix.de>
 <CAHTX3dKW1R+MKYyyFVapOvFiW0-x4z0DEUpJmuxr4j4UEWpNfw@mail.gmail.com>
Message-ID: <20130326130139.GC32647@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 26, 2013 at 01:53:06PM +0100, Michal Simek wrote:
> 2013/3/26 Steffen Trumtrar <s.trumtrar@pengutronix.de>:
> > Hi Michal!
> >
> > On Tue, Mar 26, 2013 at 01:35:31PM +0100, Michal Simek wrote:
> >> >> Hi Steffen,
> >> >> I haven't started with it but yes, I would like to do this change too.
> >> >> IRC: The original post was done by John Linn and it has to go through
> >> >> Russel I think.
> >> >> EP107 was emulating platform and none is using it right now.
> >> >> Also I hope we have removed all PSS prefix from all files.
> >> >> It was caused because we didn't know what will be commercial name for
> >> >> this product.
> >> >>
> >> >
> >> > Okay, I'm confused now. What/Where is the official for-next branch for
> >> > Zynq? MAINTAINERS says arch/arm/mach-zynq goes via
> >> >         git://git.xilinx.com/linux-xlnx.git
> >> > But the arm-next branch in there is behind mainline.
> >>
> >> That's correct. All reviewed patches go to this branch.
> >> Currently there are just old patches which were already merged via
> >> arm-soc tree to mainline to v3.9
> >> because we don't have new patches. I will add there all patches which
> >> we are discussing right now.
> >> Also this branch is merged to linux-next.
> >>
> >> > Are the patches collected in arm-soc/for-next instead?
> >>
> >> No. I am asking Arnd and Olof for merging that branch above.
> >>
> >> > If I'm doing this patch I need to have the correct base for it.
> >>
> >> Give me some time. I am incorporating all changes from your series and
> >> other comments to v2 which I will send.
> >>
> >
> > Very good. That is what I was expecting, but as you mentioned Russel,
> > I got confused, as he doesn't care for such stuff.
> 
> I mentioned Russel in connect to change machine name in
> arch/arm/tools/mach-types.
> Not about the handling zynq patches and provide the path to mainline.
> 

Ah, okay. Yes. That is right. Now we are on common ground. You should be
right there.

Regards,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
