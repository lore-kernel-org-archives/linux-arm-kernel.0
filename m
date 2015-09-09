From: bhupesh.sharma@freescale.com (Sharma Bhupesh)
Date: Wed, 9 Sep 2015 03:54:12 +0000
Subject: [PATCH v2 01/10] arm64: Use generic Layerscape SoC family naming
 & rename LS2085A to LS2080A
In-Reply-To: <CALRxmdA=TF=N=6qELR78yhvt_uwEKyHih_08toD9oqCWYtsi0g@mail.gmail.com>
References: <1441349872-4560-1-git-send-email-bhupesh.sharma@freescale.com>
 <1441349872-4560-2-git-send-email-bhupesh.sharma@freescale.com>
 <CALRxmdA=TF=N=6qELR78yhvt_uwEKyHih_08toD9oqCWYtsi0g@mail.gmail.com>
Message-ID: <BY1PR0301MB130356EF4A122A23A370611E82520@BY1PR0301MB1303.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Stuart Yoder [mailto:b08248 at gmail.com]
> Sent: Wednesday, September 09, 2015 1:55 AM
> On Fri, Sep 4, 2015 at 1:57 AM, Bhupesh Sharma
> <bhupesh.sharma@freescale.com> wrote:
> > Freescale will be a churning out a host of ARMv8 based SoCs which will
> > be based on a similar overall SoC architecture. So, this patch
> > converts the existing infrastructure in the arm64/dts, arm64/Kconfig
> > and arm64/configs to use the generic convention ARCH_LAYERSCAPE in
> > place of the more specific FSL_LS2085A, to save code duplication
> > later-on.
> >
> > Also Freescale is renaming LS2085A to LS2080A.
> >
> > This patch addresses the above two points.
> 
> Suggest splitting this into 2 patches because these 2 changes are really
> orthogonal-- one patch for the ARCH config name change, one for the
> rename ls2085a to ls2080a rename.

I was seeing the compilation breaking up at patch level if I did so.
Will try to see if this can be achieved without breaking up the compilation
for individual patches in v3.
 
> Not sure why you're describing it as "churning out a host of ARMv8 based
> SoCs".
> Just get to the point--  Layerscape is an SoC family so we're changing
> from the SoC specific ARCH kconfig option to a more general SoC family
> option.

The prologue is to describe that other ARMv8 SoCs with similar architecture
will be put-out, which will be part of the overall Layerscape family. 

Regards,
Bhupesh
