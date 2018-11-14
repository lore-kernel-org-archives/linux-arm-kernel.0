From: RAJANV@xilinx.com (Rajan Vaja)
Date: Wed, 14 Nov 2018 07:47:44 +0000
Subject: [PATCH] clk: zynqmp: handle fixed factor param query error
In-Reply-To: <26e50d25-a02b-5ece-d12d-8c6ee208a845@xilinx.com>
References: <1539762392-12512-1-git-send-email-rajan.vaja@xilinx.com>
 <153978972088.5275.4505414322881956934@swboyd.mtv.corp.google.com>
 <26e50d25-a02b-5ece-d12d-8c6ee208a845@xilinx.com>
Message-ID: <BYAPR02MB40555A10B3551DB5C29E9B7FB7C30@BYAPR02MB4055.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michal, Stephen,

> -----Original Message-----
> From: Michal Simek [mailto:michal.simek at xilinx.com]
> Sent: 05 November 2018 01:09 PM
> To: Stephen Boyd <sboyd@kernel.org>; Rajan Vaja <RAJANV@xilinx.com>; Michal
> Simek <michals@xilinx.com>; mturquette at baylibre.com; olof at lixom.net;
> Shubhrajyoti Datta <shubhraj@xilinx.com>
> Cc: Jolly Shah <JOLLYS@xilinx.com>; linux-clk at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH] clk: zynqmp: handle fixed factor param query error
> 
> On 17. 10. 18 17:22, Stephen Boyd wrote:
> > Quoting Rajan Vaja (2018-10-17 00:46:32)
> >> Return proper error code in case query for fixed factor
> >> parameter fails. This also fixes build warning for set
> >> but not used variable 'ret'.
> >>
> >> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> >
> > Fixes tag? And I think this is going through arm-soc already? If so,
> >
> > Acked-by: Stephen Boyd <sboyd@kernel.org>
> >
> > with the appropriate fixes tag added.
> 
> It was really just about to merge this via arm-soc tree because of
> dependency on firmware itself.
> It is the part of v4.20-rc1 now and it can go via your tree.
> 
> Anyway v2 is required with Fixed tag anyway.
> Rajan: Please send it v2 with Acked above.
[Rajan] I have submitted v2 with Fixes tag and Ack.

> 
> Thanks,
> Michal
