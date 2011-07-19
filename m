From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 Jul 2011 14:59:44 +0200
Subject: conflicts between omap/cleanup branch and omap_dss2 tree
In-Reply-To: <4E25784D.8070300@ti.com>
References: <201107172339.32516.arnd@arndb.de>
	<20110718080856.GW5783@atomide.com> <4E25784D.8070300@ti.com>
Message-ID: <201107191459.44992.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 July 2011, Archit Taneja wrote:
> Tomi is on vacation right now, but he checks his mail once in a while, 
> so we may get a response soon.
> 
> Tomi's for-next branch is not up to date yet. So it shouldn't be 
> considered for now. The HWMOD patches in Tomi's for-next branch will be 
> pushed by Paul as 3.1-rc fixes.
> 
> We will make a temporary branch which will contain all the DSS2 patches 
> which Tomi intended to push for this merge window, once he gets a 
> chance, he can quickly update his for-next branch with it.

Ok, just let me know when you upload that branch so I can remove the
dependency from the arm-soc tree. Right now, I'm pulling the
omap_dss2/for_next branch into arm-soc/for_next as a dependency
to resolve the conflict.

	Arnd
