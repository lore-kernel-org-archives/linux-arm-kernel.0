From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 20 Sep 2016 10:32:50 -0700
Subject: [PATCH 0/2] ARM: imx31/of: clk: init clock controller with
 CLK_OF_DECLARE
In-Reply-To: <20160919055802.dkf2rxcou44kbya5@pengutronix.de>
References: <1474252939-12579-1-git-send-email-vz@mleia.com>
 <20160919055802.dkf2rxcou44kbya5@pengutronix.de>
Message-ID: <20160920173250.GB8319@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/19, Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Mon, Sep 19, 2016 at 05:42:17AM +0300, Vladimir Zapolskiy wrote:
> > The change is based on v4.8.0-rc1 and plus it depends on this fixup:
> > 
> >   ARM: dts: imx31: fix clock control module interrupts description
> > 
> > The change is tested on qemu kzm target and mx31lite board, while both
> > targets don't have DTS in upstream, I had to write simple DTS files for
> > them, because the proposed change is for i.MX31 targets with OF support.
> > 
> > The second change in the series compilation time dependent on the first
> > one, while the first change apparently should break runtime execution
> > of i.MX31 boards with OF support, if both changes are applied everything
> > should be fine, regression testing on the same legacy targets does not
> 
> that means this should be done in a single patch.

Yes, please combine the patches. I can ack it then so it can be
routed through arm-soc.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
