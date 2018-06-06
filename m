From: yangbo.lu@nxp.com (Y.b. Lu)
Date: Wed, 6 Jun 2018 11:48:31 +0000
Subject: [PATCH 09/10] dpaa_eth: add support for hardware timestamping
In-Reply-To: <20180605135748.mlarwiyzf2oe27ax@localhost>
References: <20180604070837.19265-1-yangbo.lu@nxp.com>
 <20180604070837.19265-10-yangbo.lu@nxp.com>
 <20180604134920.ezhe6jz5ntpnqyzj@localhost>
 <DB6PR0401MB2536376432EC481473A5B4A3F8660@DB6PR0401MB2536.eurprd04.prod.outlook.com>
 <20180605135748.mlarwiyzf2oe27ax@localhost>
Message-ID: <DB6PR0401MB2536C69465964BB0BD1A4203F8650@DB6PR0401MB2536.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,

> -----Original Message-----
> From: Richard Cochran [mailto:richardcochran at gmail.com]
> Sent: Tuesday, June 5, 2018 9:58 PM
> To: Y.b. Lu <yangbo.lu@nxp.com>
> Cc: netdev at vger.kernel.org; Madalin-cristian Bucur
> <madalin.bucur@nxp.com>; Rob Herring <robh+dt@kernel.org>; Shawn Guo
> <shawnguo@kernel.org>; David S . Miller <davem@davemloft.net>;
> devicetree at vger.kernel.org; linuxppc-dev at lists.ozlabs.org;
> linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH 09/10] dpaa_eth: add support for hardware timestamping
> 
> On Tue, Jun 05, 2018 at 03:35:28AM +0000, Y.b. Lu wrote:
> > [Y.b. Lu] Actually these timestamping codes affected DPAA networking
> performance in our previous performance test.
> > That's why we used ifdef for it.
> 
> How much does time stamping hurt performance?
> 
> If the time stamping is compiled in but not enabled at run time, does it still
> affect performace?

[Y.b. Lu] I can't remember and find the old data since it had been a long time.
I just did the iperf test today between two 10G ports. I didn?t see any performance changes with timestamping code ?
So, let's me remove the ifdef in next version.
Thanks a lot.


> 
> Thanks,
> Richard
