From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 8 Oct 2015 14:37:23 +0800
Subject: [PATCH v8 2/2] ARM: imx: support suspend states on imx7D
In-Reply-To: <CAHrpEqQjp+iEYR3QhXhm2ak+CcZ4gyfK1JekCsVR78FE-0CfMw@mail.gmail.com>
References: <1438378439-11569-1-git-send-email-shenwei.wang@freescale.com>
 <1438378439-11569-3-git-send-email-shenwei.wang@freescale.com>
 <20150907151106.GA30723@tiger>
 <CY1PR0301MB084344B059A4178B09E949DF83530@CY1PR0301MB0843.namprd03.prod.outlook.com>
 <20150918141524.GC3770@tiger>
 <CY1PR0301MB0843D4E46210525521F9453483590@CY1PR0301MB0843.namprd03.prod.outlook.com>
 <20150919011247.GD3770@tiger>
 <CAHrpEqQjp+iEYR3QhXhm2ak+CcZ4gyfK1JekCsVR78FE-0CfMw@mail.gmail.com>
Message-ID: <20151008063723.GA22673@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 01, 2015 at 11:31:11AM -0500, Zhi Li wrote:
> On Fri, Sep 18, 2015 at 8:12 PM, Shawn Guo <shawnguo@kernel.org> wrote:
> > I have zero interest to maintain this pile of code in the mainline
> > kernel.  Take it as a motivation to move to PSCI soon, or you maintain
> > it on your own as a out-of-tree patch for whatever long time you like.
> >
> 
> Does it means that SMP support also need go through PSCI?

Yes, please.

Shawn
