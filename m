From: tony@atomide.com (Tony Lindgren)
Date: Tue, 7 Aug 2012 03:58:47 -0700
Subject: [PATCH] Revert "ARM: OMAP3530evm: set pendown_state and
 debounce time for ads7846"
In-Reply-To: <871ujj7ngd.fsf@ti.com>
References: <876298iv9s.fsf@ti.com>
 <1344284535-16717-1-git-send-email-grinberg@compulab.co.il>
 <871ujj7ngd.fsf@ti.com>
Message-ID: <20120807105847.GX11011@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@ti.com> [120806 13:52]:
> 
> The Overo boards were the ones that were crashing due to this bug since
> the pendown GPIO was the only one used in the bank.
> 
> Tony, can you queue this up for v3.6-rc?  I have a version in my
> for_3.6/fixes/ads7846-2 branch with the tags above applied, based on v3.6-rc1.

Yes thanks pulling into fixes.

Tony
