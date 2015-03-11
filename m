From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Mar 2015 15:33:26 +0100
Subject: [GIT PULL] SoCFPGA fixes for v4.0
In-Reply-To: <1425533136-31995-1-git-send-email-dinguyen@opensource.altera.com>
References: <1425533136-31995-1-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <3502283.YdvhXEM0kj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 March 2015 23:25:36 dinguyen at opensource.altera.com wrote:
> 
> Hi Arnd, Kevin and Olof,
> 
> Please consider pulling in these patches for v4.0. The patch from Russell is
> probably the most important as it's fixed a sporadic SMP issue where CPU1
> start address variable was being cached away, and never made it to physical
> memory.
> 

Pulled into fixes branch, thanks!

	Arnd
