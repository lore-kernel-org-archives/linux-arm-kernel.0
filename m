From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 24 Sep 2015 04:40:27 -0700
Subject: [PATCH v2] arm/ls1021a: Add Sleep feature for ls1021
In-Reply-To: <SN1PR0301MB1616B7458FB787A75DADC9369D430@SN1PR0301MB1616.namprd03.prod.outlook.com>
References: <1442308030-21231-1-git-send-email-dongsheng.wang@freescale.com>
 <20150923151333.GJ3529@tiger>
 <SN1PR0301MB1616B7458FB787A75DADC9369D430@SN1PR0301MB1616.namprd03.prod.outlook.com>
Message-ID: <20150924114026.GL3529@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 24, 2015 at 09:28:31AM +0000, Wang Dongsheng wrote:
> > > Add system STANDBY implement for ls1021 platform.
> > >
> > > Signed-off-by: Chenhui Zhao <chenhui.zhao@freescale.com>
> > > Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> > > ---
> > > *v2*:
> > > - Remove PSCI code. Just implement STANDBY in platform code.
> > 
> > Why stepping back?  We are encouraged to move to PSCI, aren't we?
> > 
> 
> As Lorenzo said, PSCI v1.0 support will be in kernel v4.4. So I remove
> psci for this patch.

v4.4 is not far away, and we should probably wait instead of pushing
the code that needs to be revised quite soon.

Shawn
