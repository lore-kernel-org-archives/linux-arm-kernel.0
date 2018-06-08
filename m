From: yangbo.lu@nxp.com (Y.b. Lu)
Date: Fri, 8 Jun 2018 04:45:20 +0000
Subject: [v3, 00/10] Support DPAA PTP clock and timestamping
In-Reply-To: <20180608042706.7gfg5p6574ntc2lq@localhost>
References: <20180607092050.46128-1-yangbo.lu@nxp.com>
 <20180608042706.7gfg5p6574ntc2lq@localhost>
Message-ID: <DB6PR0401MB25365FAE0E0C7387CB085B96F87B0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Richard Cochran [mailto:richardcochran at gmail.com]
> Sent: Friday, June 8, 2018 12:27 PM
> To: Y.b. Lu <yangbo.lu@nxp.com>
> Cc: netdev at vger.kernel.org; Madalin-cristian Bucur
> <madalin.bucur@nxp.com>; Rob Herring <robh+dt@kernel.org>; Shawn Guo
> <shawnguo@kernel.org>; David S . Miller <davem@davemloft.net>;
> devicetree at vger.kernel.org; linuxppc-dev at lists.ozlabs.org;
> linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org
> Subject: Re: [v3, 00/10] Support DPAA PTP clock and timestamping
> 
> On Thu, Jun 07, 2018 at 05:20:40PM +0800, Yangbo Lu wrote:
> > This patchset is to support DPAA FMAN PTP clock and HW timestamping.
> > It had been verified on both ARM platform and PPC platform.
> > - The patch #1 to patch #5 are to support DPAA FMAN 1588 timer in
> >   ptp_qoriq driver.
> > - The patch #6 to patch #10 are to add HW timestamping support in
> >   DPAA ethernet driver.
> 
> Right now, net-next is closed for new stuff.  You will have to post the series
> again after the merge window closes.  You can check the status here:
> 
> 
> https://emea01.safelinks.protection.outlook.com/?url=http:%2F%2Fvger.kern
> el.org%2F~davem%2Fnet-next.html&data=02%7C01%7Cyangbo.lu%40nxp.co
> m%7Cbaab0b22e7444386c37008d5ccf81b37%7C686ea1d3bc2b4c6fa92cd99
> c5c301635%7C0%7C0%7C636640288347563742&sdata=jCmNlwoeWA50PV4
> w3lKZ%2Fs4akPjw0VV2OrJ3t4FizJ0%3D&reserved=0
> 
> When you do re-post, you can add my:
> 
> Acked-by: Richard Cochran <richardcochran@gmail.com>

[Y.b. Lu] Get it. And thanks a lot ?
