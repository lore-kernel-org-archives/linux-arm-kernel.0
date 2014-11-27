From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Nov 2014 14:02:48 +0100
Subject: [PATCH 1/2] ARM: tegra: irq: fix buggy usage of irq_data irq field
In-Reply-To: <20141127120826.GA25222@ulmo>
References: <1417024532-5777-1-git-send-email-marc.zyngier@arm.com>
 <5476EA0A.7090406@arm.com> <20141127120826.GA25222@ulmo>
Message-ID: <5826341.lADJtgptEV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 November 2014 13:08:28 Thierry Reding wrote:
> 
> > I'd be tempted to consider it as a fix for 3.18, as the current code is
> > obviously wrong. Just let me know how you want to get it in.
> 
> That's fine with me:
> 
> Acked-by: Thierry Reding <treding@nvidia.com>
> 
> Arnd, is this anything you could pick up for 3.18?
> 

Sure, no problem. Applied to fixes branch now.

	Arnd
