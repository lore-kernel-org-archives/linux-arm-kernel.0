From: Peter.Chen@freescale.com (Peter Chen)
Date: Wed, 16 Apr 2014 05:47:58 +0000
Subject: USB OTG support on mx27pdk
In-Reply-To: <CAOMZO5Bf67mf_8eTnHpx3mB6nrON4Nriwzb+En4BE6-DOwNS8Q@mail.gmail.com>
References: <CAOMZO5BcTP=fvYDE8EU2Y2Syn=QqbPd4zaQ96mSfy-mgLEjOmA@mail.gmail.com>
 <2394b8be344646358b23a105c8725961@BL2PR03MB226.namprd03.prod.outlook.com>
 <CAOMZO5Bf67mf_8eTnHpx3mB6nrON4Nriwzb+En4BE6-DOwNS8Q@mail.gmail.com>
Message-ID: <19fff80e08e9451a99f9333421e41264@BL2PR03MB226.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> On Wed, Apr 16, 2014 at 12:23 AM, Peter Chen <Peter.Chen@freescale.com>
> wrote:
> > Please check if below patch is existed
> >
> > commit 3b5d3e6845bfe68777d069886b0d1cd5f23b9d58
> > Author: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> > Date:   Fri Jan 10 13:51:29 2014 +0800
> >
> >     usb: chipidea: Fix Internal error: : 808 [#1] ARM related to STS
> flag
> >
> >     * init the sts flag to 0 (missed)
> >     * fix write the real bit not sts value
> >     * Set PORTCS_STS and DEVLC_STS only if sts = 1
> >
> >
> > I cced chris who has imx27 hardware.
> 
> Yes, this patch is applied in 3.15-rc1, but does not help here.
> 

Just tried one imx6dl board, it works well.
Have a look if it is related to phy_type at dts or phy driver please.

Peter
