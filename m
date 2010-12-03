From: tony@atomide.com (Tony Lindgren)
Date: Thu, 2 Dec 2010 17:10:57 -0800
Subject: [PATCH] arm: omap2: io: fix clk_get() error check
In-Reply-To: <87vd3c4h8p.fsf@deeprootsystems.com>
References: <1291126678-2782-1-git-send-email-aaro.koskinen@nokia.com>
	<87vd3c4h8p.fsf@deeprootsystems.com>
Message-ID: <20101203011057.GD17222@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@deeprootsystems.com> [101202 02:01]:
> Aaro Koskinen <aaro.koskinen@nokia.com> writes:
> 
> > clk_get() return value should be checked with IS_ERR().
> >
> > Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
> 
> Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

Thanks, will queue.

Tony
