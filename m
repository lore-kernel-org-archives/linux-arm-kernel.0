From: yuantian.tang@nxp.com (Y.T. Tang)
Date: Fri, 25 Nov 2016 03:32:38 +0000
Subject: [PATCH v3] clk: qoriq: added ls1012a clock configuration
In-Reply-To: <DB5PR0401MB1928925ACE6E6E066961C64A91B60@DB5PR0401MB1928.eurprd04.prod.outlook.com>
References: <1479955015-37514-1-git-send-email-yuantian.tang@nxp.com>
 <DB5PR0401MB1928925ACE6E6E066961C64A91B60@DB5PR0401MB1928.eurprd04.prod.outlook.com>
Message-ID: <DB6PR0402MB2837A0811DDF5A5DC9E82EF7F0890@DB6PR0402MB2837.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Scott,

> -----Original Message-----
> From: Scott Wood
> Sent: Thursday, November 24, 2016 4:21 PM
> To: Y.T. Tang <yuantian.tang@nxp.com>; mturquette at baylibre.com
> Cc: sboyd at codeaurora.org; linux-clk at vger.kernel.org; linux-
> kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v3] clk: qoriq: added ls1012a clock configuration
> 
> On 11/23/2016 08:50 PM, yuantian.tang at nxp.com wrote:
> > From: Tang Yuantian <Yuantian.Tang@nxp.com>
> >
> > Signed-off-by: Tang Yuantian <yuantian.tang@nxp.com>
> > ---
> > v3:
> >   - rebased to latest kernel and re-sorted the code
> [snip]
> > @@ -1316,6 +1334,7 @@ CLK_OF_DECLARE(qoriq_clockgen_2,
> > "fsl,qoriq-clockgen-2.0", clockgen_init);
> > CLK_OF_DECLARE(qoriq_clockgen_ls1021a, "fsl,ls1021a-clockgen",
> > clockgen_init);  CLK_OF_DECLARE(qoriq_clockgen_ls1043a,
> > "fsl,ls1043a-clockgen", clockgen_init);
> > CLK_OF_DECLARE(qoriq_clockgen_ls1046a, "fsl,ls1046a-clockgen",
> > clockgen_init);
> > +CLK_OF_DECLARE(qoriq_clockgen_ls1012a, "fsl,ls1012a-clockgen",
> > +clockgen_init);
> >  CLK_OF_DECLARE(qoriq_clockgen_ls2080a, "fsl,ls2080a-clockgen",
> > clockgen_init);
> 
> You need a better sorting algorithm. :-P
> 
I don't think so. This time, each code snip goes right after ls1046a.
The sorting 'algorithm' is best ever. :)

Regards,
Yuantian
 
> -Scott
