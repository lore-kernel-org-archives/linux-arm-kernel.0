From: yangbo.lu@nxp.com (Y.b. Lu)
Date: Wed, 1 Aug 2018 10:10:24 +0000
Subject: [PATCH 3/3] ptp_qoriq: convert to use module parameters for
 initialization
In-Reply-To: <20180801061515.krn52iaq2kqdi3wo@localhost>
References: <20180730100154.27906-1-yangbo.lu@nxp.com>
 <20180730100154.27906-3-yangbo.lu@nxp.com>
 <20180730143043.qu66ttzwyjbw6si7@localhost>
 <DB6PR0401MB253643010802739AD55820F3F82D0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
 <20180801061515.krn52iaq2kqdi3wo@localhost>
Message-ID: <DB6PR0401MB2536CE4BCEE872F2C4D63710F82D0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,

> -----Original Message-----
> From: Richard Cochran [mailto:richardcochran at gmail.com]
> Sent: Wednesday, August 1, 2018 2:15 PM
> To: Y.b. Lu <yangbo.lu@nxp.com>
> Cc: netdev at vger.kernel.org; Madalin-cristian Bucur
> <madalin.bucur@nxp.com>; Rob Herring <robh+dt@kernel.org>; Shawn Guo
> <shawnguo@kernel.org>; David S . Miller <davem@davemloft.net>;
> devicetree at vger.kernel.org; linuxppc-dev at lists.ozlabs.org;
> linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH 3/3] ptp_qoriq: convert to use module parameters for
> initialization
> 
> On Wed, Aug 01, 2018 at 04:36:40AM +0000, Y.b. Lu wrote:
> 
> > Could I add a function to calculate a set of default register values
> > to initialize ptp timer when dts method failed to get required
> > properties in driver?
> 
> Yes, it would be ideal if the driver can pick correct values automatically.
> 
> However, the frequency on the FIPER outputs can't be configured
> automatically, and we don't have an API for the user to choose this.

[Y.b. Lu] Thanks a lot. Just let me send out the v2 patch for your reviewing.

> 
> > I think this will be useful. The ptp timer on new platforms (you may
> > see two dts patches in this patchset. Many platforms will be
> > affected.) will work without these dts properties. If user want
> > specific setting, they can set dts properties.
> 
> Sure.
> 
> Thanks,
> Richard
