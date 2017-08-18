From: briannorris@chromium.org (Brian Norris)
Date: Fri, 18 Aug 2017 10:07:17 -0700
Subject: [RFC PATCH v2 1/3] PCI: rockchip: Add support for pcie wake irq
In-Reply-To: <20170818170107.GA119461@google.com>
References: <20170817120431.12398-1-jeffy.chen@rock-chips.com>
 <20170817120431.12398-2-jeffy.chen@rock-chips.com>
 <20170818170107.GA119461@google.com>
Message-ID: <20170818170716.GB119461@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 18, 2017 at 10:01:07AM -0700, Brian Norris wrote:
> + Tony
> 
> On Thu, Aug 17, 2017 at 08:04:29PM +0800, Jeffy Chen wrote:
> > Add support for PCIE_WAKE pin in rockchip pcie driver.
> > 
> > Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> > ---
> > 
> > Changes in v2:
> > Use dev_pm_set_dedicated_wake_irq
> >         -- Suggested by Brian Norris <briannorris@chromium.com>

Oops, I forgot you sent a v3. Same questions/comments apply there
though.
