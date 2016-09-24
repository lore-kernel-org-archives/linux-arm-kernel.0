From: shawnguo@kernel.org (Shawn Guo)
Date: Sat, 24 Sep 2016 22:08:17 +0800
Subject: [PATCH v6 2/4] arm64: dts: Add timer erratum property for
 LS2080A and LS1043A
In-Reply-To: <20160923162755.GG6397@arm.com>
References: <1474533318-7796-1-git-send-email-oss@buserror.net>
 <1474533318-7796-2-git-send-email-oss@buserror.net>
 <20160923162755.GG6397@arm.com>
Message-ID: <20160924140817.GA11051@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 23, 2016 at 05:27:56PM +0100, Will Deacon wrote:
> On Thu, Sep 22, 2016 at 03:35:16AM -0500, Scott Wood wrote:
> > Signed-off-by: Scott Wood <oss@buserror.net>
> > ---
> >  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 1 +
> >  arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi | 1 +
> >  2 files changed, 2 insertions(+)
> 
> This patch conflicts with mainline,

Thanks for the heads-up.

> but I've queued the other three
> patches in the series in the arm64 tree.
> 
> Please send the updated .dts changes via arm-soc.

I will send this to arm-soc when v4.9-rc1 comes out with driver changes
in place.

Shawn
