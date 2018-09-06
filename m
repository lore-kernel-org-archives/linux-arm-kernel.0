From: MNARANI@xilinx.com (Manish Narani)
Date: Thu, 6 Sep 2018 15:21:49 +0000
Subject: [PATCH v5 2/4] dt: bindings: Document ZynqMP DDRC in Synopsys
 documentation
In-Reply-To: <20180904141618.GA5516@bogus>
References: <1535722070-10394-1-git-send-email-manish.narani@xilinx.com>
 <1535722070-10394-3-git-send-email-manish.narani@xilinx.com>
 <20180904141618.GA5516@bogus>
Message-ID: <DM6PR02MB52276BECB56DCAB7576CDB53C1010@DM6PR02MB5227.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

> -----Original Message-----
> From: Rob Herring [mailto:robh at kernel.org]
> Sent: Tuesday, September 4, 2018 7:46 PM
> To: Manish Narani <MNARANI@xilinx.com>
> Cc: mark.rutland at arm.com; Michal Simek <michals@xilinx.com>;
> bp at alien8.de; mchehab at kernel.org; leoyang.li at nxp.com;
> amit.kucheria at linaro.org; olof at lixom.net; Srinivas Goud <sgoud@xilinx.com>;
> Anirudha Sarangi <anirudh@xilinx.com>; linux-kernel at vger.kernel.org;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> edac at vger.kernel.org
> Subject: Re: [PATCH v5 2/4] dt: bindings: Document ZynqMP DDRC in Synopsys
> documentation
> 
> On Fri, Aug 31, 2018 at 06:57:48PM +0530, Manish Narani wrote:
> > Add information of ZynqMP DDRC which reports the single bit errors
> > that are corrected and the double bit errors that are detected.
> >
> > Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> > ---
> >  .../bindings/memory-controllers/synopsys.txt       | 27 ++++++++++++++++++-
> ---
> >  1 file changed, 22 insertions(+), 5 deletions(-)
> 
> Please add acks/reviewed-bys when posting new versions.
Sure. I will include it in v6.

Thanks,
Manish Narani
