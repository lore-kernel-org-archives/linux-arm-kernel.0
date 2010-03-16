From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Tue, 16 Mar 2010 08:11:19 +0200
Subject: [PATCH 2/3] ep93xx: added chip revision reading function
In-Reply-To: <56d259a01003151244l352eeb50p95e97912b3df159a@mail.gmail.com>
References: <cover.1268669236.git.mika.westerberg@iki.fi>
	<774b9c08b6e9484a2ca5084b8b6019aa18dddd99.1268669236.git.mika.westerberg@iki.fi>
	<3d93e748eb068963a9378b454ba9cd117cbbc737.1268669236.git.mika.westerberg@iki.fi>
	<56d259a01003151244l352eeb50p95e97912b3df159a@mail.gmail.com>
Message-ID: <20100316061119.GC12813@gw.healthdatacare.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 15, 2010 at 07:44:27PM +0000, Martin Guy wrote:
> Hi Mika, thanks, great work
> 
> On 3/15/10, Mika Westerberg <mika.westerberg@iki.fi> wrote:
> > Added a new function: ep93xx_chip_revision() which reads chip revision from the
> >  sysconfig register.
> >
> >  + * %EP93XX_CHIP_REV_D0
> >  + * %EP93XX_CHIP_REV_D1
> >  + * %EP93XX_CHIP_REV_E0
> >  + * %EP93XX_CHIP_REV_E1
> >  + * %EP93XX_CHIP_REV_E2
> >  + *
> >  + * and in future maybe something else. See also <mach/platform.h>.
> 
> There will be no future revisions, if that's what you mean. Cirrus
> dropped out of the ARM business and discontinued development of this
> product line on 1st April 2008 so E2 is the last.

That's what I meant and I didn't know that :(

I will update the comment in next series.

Thanks,
MW
