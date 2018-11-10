From: aisheng.dong@nxp.com (A.s. Dong)
Date: Sat, 10 Nov 2018 16:05:44 +0000
Subject: [PATCH v9 3/5] clk: imx: add SCCG PLL type
In-Reply-To: <154170172752.88331.2213352243956732809@swboyd.mtv.corp.google.com>
References: <1537785597-26499-1-git-send-email-abel.vesa@nxp.com>
 <1537785597-26499-4-git-send-email-abel.vesa@nxp.com>
 <153980615257.5275.13866740376184829057@swboyd.mtv.corp.google.com>
 <20181107115444.gscxwud7e57nx3c7@fsr-ub1664-175>
 <154161726247.88331.15629902810537417880@swboyd.mtv.corp.google.com>
 <20181107202624.oya2runvbbwcilzu@fsr-ub1664-175>
 <154163631513.88331.1765456171211364913@swboyd.mtv.corp.google.com>
 <20181108122938.mnhu3ttnlztfeyot@fsr-ub1664-175>
 <154170172752.88331.2213352243956732809@swboyd.mtv.corp.google.com>
Message-ID: <AM0PR04MB42118C6960C39387051B57F280C70@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

[...]
> > I already sent the 12th version of this current patch series and I
> > would really like to get this in ASAP so that the booting up of imx8mq will
> not be delayed.
> >
> 
> Ok. Well we're in rc1 right now, and so we're not merging new drivers into
> mainline. I can merge the clk driver into clk-next, but you'll have to wait for the
> stabilization period to end (approximately 6 or 7 weeks) before this can get
> into the next kernel version. It will be in linux-next much sooner of course.

That would be great if you can help that.
We're now working with SUSE to enable i.MX8 support.
Their criteria is only backporting patches which must be at least in maintainer's
next tree already. So either picked up by you or Shawn would help a lot on it.

BTW, one simple question is that because MX8MQ DTS patches depends on
this clock driver series. How would you suggest this series to go through
your tree or Shawn's tree?

Regards
Dong Aisheng
