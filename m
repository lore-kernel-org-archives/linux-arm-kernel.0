From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 7 Feb 2013 17:25:01 +0000
Subject: [PATCHv3 4/4] arm: Add generic timer broadcast support
In-Reply-To: <5113DB2F.9090606@wwwdotorg.org>
References: <1358183124-28461-1-git-send-email-mark.rutland@arm.com>
 <1358183124-28461-5-git-send-email-mark.rutland@arm.com>
 <5112C25F.6000508@wwwdotorg.org>
 <20130207100403.GD16987@e106331-lin.cambridge.arm.com>
 <5113DB2F.9090606@wwwdotorg.org>
Message-ID: <20130207172501.GC28072@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

> > The intent of 12ad100046: "clockevents: Add generic timer broadcast function"
> > was to setup the broadcast function both for non-functional/dummy timers and
> > those that stop in low-power states (CLOCK_EVT_FEAT_C3STOP). I missed the
> > CLOCK_EVT_FEAT_C3STOP case.
> > 
> > I believe the patch below will fix this for Tegra and any other platforms where
> > broadcast is required in low power states.
> > 
> > Stephen, could you test this for Tegra?
> 
> Tested-by: Stephen Warren <swarren@nvidia.com>

Thanks. Sorry for the bother.

Mark.
