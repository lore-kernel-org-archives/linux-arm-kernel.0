From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 May 2014 22:08:56 +0200
Subject: [PATCH v4 0/5] Add platform support for LSI AXM55xx
In-Reply-To: <cover.1400834521.git.anders.berg@avagotech.com>
References: <cover.1400834521.git.anders.berg@avagotech.com>
Message-ID: <201405232208.56676.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 23 May 2014, Anders Berg wrote:
> Hi,
> 
> Here is version 4 of platform support for AXM5516 SoC.
> 
> The clk driver is now applied to clk-next. The rest should be ready for
> arm-soc. Haven't got any response from the power/reset maintainers... I hope
> this driver can be taken via arm-soc as well.

I've merged it all into the next/soc branch now, thanks!

In the future when submitting patches for inclusion, please add the arm at kernel.org
alias to Cc to ensure we don't miss it.

	ARnd
