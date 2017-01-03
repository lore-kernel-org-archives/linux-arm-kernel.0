From: meng.yi@nxp.com (Meng Yi)
Date: Tue, 3 Jan 2017 02:24:04 +0000
Subject: [PATCH] arm64/dts/ls2080a-rdb: remove disable status of pca9547
In-Reply-To: <20170102091705.GI20956@dragon>
References: <1482213787-27814-1-git-send-email-meng.yi@nxp.com>
 <20170102091705.GI20956@dragon>
Message-ID: <HE1PR0401MB2634D7F342D979D4FC36389AEC6E0@HE1PR0401MB2634.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: Monday, January 02, 2017 5:17 PM
> To: Meng Yi <meng.yi@nxp.com>
> Cc: robh+dt at kernel.org; Stuart Yoder <stuart.yoder@nxp.com>; linux-
> kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH] arm64/dts/ls2080a-rdb: remove disable status of pca9547
> 
> On Tue, Dec 20, 2016 at 02:03:07PM +0800, Meng Yi wrote:
> > pca9547 won't probed since its status property is disabled.
> > while there are devices connected to it, we need remove status
> > property to let ds3232 and adt7461 probed correctly.
> >
> > Signed-off-by: Meng Yi <meng.yi@nxp.com>
> 
> Changed subject prefix to 'arm64: dts: ls2080a-rdb: ', and applied the patch.
> 
> Shawn

Thanks!

Meng
