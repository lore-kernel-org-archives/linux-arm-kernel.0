From: aisheng.dong@nxp.com (A.s. Dong)
Date: Mon, 27 Aug 2018 03:42:52 +0000
Subject: [PATCH V4 0/9] clk: add imx7ulp clk support
In-Reply-To: <5a5950a4-e164-a604-ccb4-ae6d5bbe1708@baylibre.com>
References: <1531921023-18497-1-git-send-email-aisheng.dong@nxp.com>
 <AM0PR04MB421169829CFE1A6A32DCC209802B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <5a5950a4-e164-a604-ccb4-ae6d5bbe1708@baylibre.com>
Message-ID: <AM0PR04MB4211EB200D335FCEC382BD0E800B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

> -----Original Message-----
> From: Alexandre Bailon [mailto:abailon at baylibre.com]
> Sent: Wednesday, August 8, 2018 6:01 PM
> To: A.s. Dong <aisheng.dong@nxp.com>; linux-clk at vger.kernel.org;
> sboyd at kernel.org
> Cc: Jacky Bai <ping.bai@nxp.com>; Anson Huang <anson.huang@nxp.com>;
> mturquette at baylibre.com; linux-kernel at vger.kernel.org; dl-linux-imx
> <linux-imx@nxp.com>; shawnguo at kernel.org;
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH V4 0/9] clk: add imx7ulp clk support
> 
> Hi Dong Aisheng,
> 
> On 07/26/2018 03:50 AM, A.s. Dong wrote:
> > Hi Stephen,
> >
> > Do you have a chance to look at it?
> > This patch series has been pending for quite a long time without much
> comments.
> I'm not a kernel maintainer but I would not review a series that has checkpatch
> errors.
> Please run checkpatch, fix the errors and the warnings, and then resubmit a
> series.

Yes, I did it. There're some warnings. But unlike errors, normally warnings are judgable.
For this patch set, all known warnings seems to me not need the fix. 
E.g. line over 80 or missing maintainer for new files....

BTW there's one special warning I don't see how to fix, seems reported wrongly.

0005-clk-imx-add-composite-clk-support.patch
--------------------------------------------
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#47: 
new file mode 100644

WARNING: function definition argument 'const char * const' should also have an identifier name
#145: FILE: drivers/clk/imx/clk.h:74:
+struct clk_hw *imx_clk_composite(const char *name,

total: 0 errors, 2 warnings, 104 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

If you have better suggestions please let me know.

Regards
Dong Aisheng
