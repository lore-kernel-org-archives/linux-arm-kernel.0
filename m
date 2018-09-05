From: ran.wang_1@nxp.com (Ran Wang)
Date: Wed, 5 Sep 2018 02:22:55 +0000
Subject: [PATCH 2/3] Documentation: dt: binding: fsl: update property
 description for RCPM
In-Reply-To: <5b8e8a71.1c69fb81.d966f.1ca1@mx.google.com>
References: <20180831035219.31619-1-ran.wang_1@nxp.com>
 <20180831035219.31619-2-ran.wang_1@nxp.com>
 <5b8e8a71.1c69fb81.d966f.1ca1@mx.google.com>
Message-ID: <AM5PR0402MB28659BF8C2B5B3B18DB6BAC9F1020@AM5PR0402MB2865.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Tuesday, September 04, 2018 09:25
> To: Ran Wang <ran.wang_1@nxp.com>
> Cc: Leo Li <leoyang.li@nxp.com>; Mark Rutland <mark.rutland@arm.com>;
> linuxppc-dev at lists.ozlabs.org; linux-arm-kernel at lists.infradead.org;
> devicetree at vger.kernel.org; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH 2/3] Documentation: dt: binding: fsl: update property
> description for RCPM
> 
> On Fri, Aug 31, 2018 at 11:52:18AM +0800, Ran Wang wrote:
> > Add property 'big-endian' and supportted IP's configuration info.
> > Remove property 'fsl,#rcpm-wakeup-cell'.
> 
> "dt-bindings: soc: ..." for the subject
> 
> It is obvious reading the diff you are removing fsl,#rcpm-wakeup-cell.
> What is not obvious is why? The commit msg should answer that.

Sure, I will add this in next version patch.

> You also are mixing several things in this patch like adding ls1012 which you
> don't mention. Please split.

Got it, will split them and add more information in next version.
 
Ran
> >
> > Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/soc/fsl/rcpm.txt |   42 ++++++-----------
> --
> >  1 files changed, 13 insertions(+), 29 deletions(-)
