From: MNARANI@xilinx.com (Manish Narani)
Date: Mon, 24 Sep 2018 10:16:26 +0000
Subject: [PATCH v7 2/7] edac: synps: Add platform specific structures for
 ddrc controller
In-Reply-To: <20180921091532.GC30439@nazgul.tnic>
References: <1537194305-9243-1-git-send-email-manish.narani@xilinx.com>
 <1537194305-9243-3-git-send-email-manish.narani@xilinx.com>
 <20180918075522.GC22202@nazgul.tnic>
 <DM6PR02MB5227F5B1B329C903BA64A27CC11C0@DM6PR02MB5227.namprd02.prod.outlook.com>
 <20180919111553.GA9140@nazgul.tnic>
 <DM6PR02MB52279753E7FD04587393DC08C11C0@DM6PR02MB5227.namprd02.prod.outlook.com>
 <20180921090721.GB30439@nazgul.tnic> <20180921091532.GC30439@nazgul.tnic>
Message-ID: <DM6PR02MB5227592B66080409835C6CBDC1170@DM6PR02MB5227.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

Thanks for the review.

> -----Original Message-----
> From: Borislav Petkov [mailto:bp at alien8.de]
> Sent: Friday, September 21, 2018 2:46 PM
> To: Manish Narani <MNARANI@xilinx.com>
> Cc: robh+dt at kernel.org; mark.rutland at arm.com; mchehab at kernel.org;
> Michal Simek <michals@xilinx.com>; leoyang.li at nxp.com;
> sudeep.holla at arm.com; amit.kucheria at linaro.org;
> devicetree at vger.kernel.org; linux-kernel at vger.kernel.org; linux-
> edac at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v7 2/7] edac: synps: Add platform specific structures for
> ddrc controller
> 
> There's more:
> 
> I said:
> 
> > > @@ -370,12 +398,12 @@ static int synps_edac_init_csrows(struct
> > > mem_ctl_info *mci)
> 
> > That function returns 0 unconditionally. Make it a void in a prepatch.
> 
> But you've lumped this change together with a bunch more. Maybe my request
> wasn't clear so let me rephrase it:
> 
> That function returns 0 unconditionally. Make it a void in a *separate*
> prepatch.
> 
> Ok?
Yes, okay. ? I will keep it in a separate prepatch in v8. 

Thanks,
Manish
