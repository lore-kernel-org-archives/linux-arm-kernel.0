From: MNARANI@xilinx.com (Manish Narani)
Date: Wed, 19 Sep 2018 05:08:50 +0000
Subject: [PATCH v7 1/7] edac: synopsys: Fix code comments and naming
 convention
In-Reply-To: <20180918075311.GB22202@nazgul.tnic>
References: <1537194305-9243-1-git-send-email-manish.narani@xilinx.com>
 <1537194305-9243-2-git-send-email-manish.narani@xilinx.com>
 <20180918075311.GB22202@nazgul.tnic>
Message-ID: <DM6PR02MB52271CFF653377B4810CD305C11C0@DM6PR02MB5227.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

Thanks a lot for the review.

> -----Original Message-----
> From: Borislav Petkov [mailto:bp at alien8.de]
> Sent: Tuesday, September 18, 2018 1:23 PM
> To: Manish Narani <MNARANI@xilinx.com>
> Cc: robh+dt at kernel.org; mark.rutland at arm.com; mchehab at kernel.org;
> Michal Simek <michals@xilinx.com>; leoyang.li at nxp.com;
> sudeep.holla at arm.com; amit.kucheria at linaro.org;
> devicetree at vger.kernel.org; linux-kernel at vger.kernel.org; linux-
> edac at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v7 1/7] edac: synopsys: Fix code comments and naming
> convention
> 
> On Mon, Sep 17, 2018 at 07:54:59PM +0530, Manish Narani wrote:
> > Update the comments in the Synopsys EDAC driver. Minor changes to
> > function names and return types are also included.
> >
> > Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> > ---
> >  drivers/edac/synopsys_edac.c | 176
> > ++++++++++++++++++++-----------------------
> >  1 file changed, 80 insertions(+), 96 deletions(-)
> 
> So this patch does a bunch of things together and should be split into:
> 
> * functional changes like code cleanup
> * functions renaming
> * comments cleanup
> 
> Maybe in that order.
> 
> This way you'll have one logical set of changes per patch and review will be
> almost trivial.
> 
Okay, I will do that in v8.

Thanks,
Manish
