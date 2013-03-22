From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 Mar 2013 19:34:08 +0000
Subject: [PATCH v2 09/13] ARM: spear: make clock driver independent of
 headers
In-Reply-To: <20130322185149.834.73861@quantum>
References: <1363106816-9603-1-git-send-email-arnd@arndb.de>
 <1363106816-9603-10-git-send-email-arnd@arndb.de>
 <20130322185149.834.73861@quantum>
Message-ID: <201303221934.08811.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 22 March 2013, Mike Turquette wrote:
> Do you want this patch to go through clk-next, or all together with the
> rest of the series?

I would prefer to keep this together with the other patches, since last
patch depends on all earlier ones.

	Arnd
