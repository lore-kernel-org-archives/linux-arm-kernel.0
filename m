From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 29 Mar 2017 10:57:44 +0800
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Select SMSC_PHY
In-Reply-To: <1490699810.3546.10.camel@nxp.com>
References: <82d0aeeaed87ae5c9390b889cef4c54d715cde61.1490191972.git.leonard.crestez@nxp.com>
 <20170324064318.GD12604@b29396-OptiPlex-7040>
 <1490699810.3546.10.camel@nxp.com>
Message-ID: <20170329025742.GU30608@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 28, 2017 at 02:16:50PM +0300, Leonard Crestez wrote:
> On Fri, 2017-03-24 at 14:43 +0800, Dong Aisheng wrote:
> > Hi Leonard,
> > 
> > On Wed, Mar 22, 2017 at 04:27:37PM +0200, Leonard Crestez wrote:
> > > 
> > > The imx6sl-evk board has a LAN8720A ethernet phy supported by SMSC_PHY.
> > > Add this driver to the default imx config since the device is present on
> > > one of the evaluation boards.
> > Upstream currently no evaluation board support.
> > 
> > This may leave to Shawn to decide whether apply it.
> 
> Really? But the dts for this eval board is included in upstream. Shouldn't the
> default config try to work with the default imx*.dts files included?
> 
> > > This used to work mostly fine with the generic phy driver but since
> > > commit 0878fff1f42c18e448ab5b8b4f6a3eb32365b5b6 that driver no longer
> > I guess you should get a checkpatch error here.
> 
> Because I didn't reference that other commit right? Sorry about this.
> 
> Should I submit again with an improved commit message?

Yes, please, and make sure that checkpatch.pl is happy about the patch.

Shawn
