From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Sep 2014 00:10:38 +0200
Subject: [GIT PULL 4/4] omap clean-up for v3.18 merge window
In-Reply-To: <pull-1411070912-460910-4>
References: <pull-1411070912-460910> <pull-1411070912-460910-4>
Message-ID: <201409260010.38431.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 18 September 2014, Tony Lindgren wrote:
> Clean-up for omaps for v3.18 merge window:
> 
> - Remove unused pieces of the legacy DMA API as we're moving to
>   dmaengine API
> 
> - Search and replace to standardize on pr_warn instead of pr_warning
> 

Nice cleanup!

Merged into next/cleanup, thanks!

	Arnd
