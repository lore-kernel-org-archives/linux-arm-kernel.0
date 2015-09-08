From: b08248@gmail.com (Stuart Yoder)
Date: Tue, 8 Sep 2015 15:24:53 -0500
Subject: [PATCH v2 01/10] arm64: Use generic Layerscape SoC family naming
 & rename LS2085A to LS2080A
In-Reply-To: <1441349872-4560-2-git-send-email-bhupesh.sharma@freescale.com>
References: <1441349872-4560-1-git-send-email-bhupesh.sharma@freescale.com>
 <1441349872-4560-2-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <CALRxmdA=TF=N=6qELR78yhvt_uwEKyHih_08toD9oqCWYtsi0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 4, 2015 at 1:57 AM, Bhupesh Sharma
<bhupesh.sharma@freescale.com> wrote:
> Freescale will be a churning out a host of ARMv8 based SoCs which
> will be based on a similar overall SoC architecture. So, this patch
> converts the existing infrastructure in the arm64/dts, arm64/Kconfig
> and arm64/configs to use the generic convention ARCH_LAYERSCAPE
> in place of the more specific FSL_LS2085A, to save code duplication
> later-on.
>
> Also Freescale is renaming LS2085A to LS2080A.
>
> This patch addresses the above two points.

Suggest splitting this into 2 patches because these 2 changes are really
orthogonal-- one patch for the ARCH config name change, one for the rename
ls2085a to ls2080a rename.

Not sure why you're describing it as "churning out a host of ARMv8 based SoCs".
Just get to the point--  Layerscape is an SoC family so we're changing from the
SoC specific ARCH kconfig option to a more general SoC family option.

Thanks,
Stuart
