From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 May 2015 16:41:57 +0200
Subject: [GIT PULL] omap fixes against v4.1-rc3
In-Reply-To: <20150512023907.GE3409@atomide.com>
References: <20150512023907.GE3409@atomide.com>
Message-ID: <2162994.JoBjLhOA5b@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 11 May 2015 19:39:07 Tony Lindgren wrote:
> Few fixes for omap clocks, PRM and hwmod code:
> 
> - Fix bogus comparison of struct clk pointers, turns out
>   we can fix it by just removing the comparison
> 
> - Fix am437 hardreset implementation and remove boottime
>   warnings by adding the VPFE hwmod data
> 
> - Regression fix for am43xx PRM code, simplify things
>   by reusing the omap4 PRM implementation
> 
> 

Pulled into the fixes branch, thanks!

	Arnd
