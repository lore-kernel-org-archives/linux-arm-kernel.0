From: Anson.Huang@freescale.com (Anson.Huang at freescale.com)
Date: Thu, 19 Dec 2013 06:52:29 +0000
Subject: [PATCH 2/3] thermal: imx: add necessary clk operation
In-Reply-To: <20131219062450.GC4148@tarshish>
References: <1387477045-19037-1-git-send-email-b20788@freescale.com>
 <1387477045-19037-2-git-send-email-b20788@freescale.com>
 <20131219062450.GC4148@tarshish>
Message-ID: <56958e0099194dc69d3d91a2ac8a97b2@DM2PR03MB317.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Best Regards.
Anson huang ???
?
Freescale Semiconductor Shanghai
?????????192?A?2?
201203
Tel:021-28937058


>-----Original Message-----
>From: Baruch Siach [mailto:baruch at tkos.co.il]
>Sent: Thursday, December 19, 2013 2:25 PM
>To: Huang Yongcai-B20788
>Cc: shawn.guo at linaro.org; kernel at pengutronix.de; rui.zhang at intel.com;
>eduardo.valentin at ti.com; devicetree at vger.kernel.org; linux-pm at vger.kernel.org;
>linux-arm-kernel at lists.infradead.org; linux-doc at vger.kernel.org
>Subject: Re: [PATCH 2/3] thermal: imx: add necessary clk operation
>
>Hi Anson,
>
>On Thu, Dec 19, 2013 at 01:17:24PM -0500, Anson Huang wrote:
>> +	if (IS_ERR(data->thermal_clk)) {
>> +		ret = IS_ERR(data->thermal_clk);
>
>You probably what to return PTR_ERR here.
>

Yes, thanks, will fix it in V2.
[Anson] 


>baruch
>
>> +		dev_err(&pdev->dev, "failed to get thermal clk!\n");
>> +		return ret;
>> +	}
>
>--
>     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
>=}------------------------------------------------ooO--U--Ooo------------{=
>   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
>
