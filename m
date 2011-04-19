From: alexander.stevens@uqconnect.edu.au (Alexander Stevens)
Date: Tue, 19 Apr 2011 08:18:37 +0000 (UTC)
Subject: [PATCH] arm: omap2: enable smc instruction for sleep34xx
References: <1301581164-26538-1-git-send-email-oskar.andero@sonyericsson.com>
	<00D61D20F3A8774CBC77798B3FBC427082058F986D@seldmbx02.corpusers.net>
Message-ID: <loom.20110419T100624-335@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ander?, Oskar <Oskar.Andero <at> sonyericsson.com> writes:

> 
> Ping!
> 
> Anyone else that gets bitten by the following when compiling
omap2plus_defconfig with gcc 4.5:
> arch/arm/mach-omap2/sleep34xx.S:150: Error: selected processor does not
support ARM mode `smc #1'
> 
> -Oskar
> 

I can report that I get the exact same compile error as this.
OP patch worked beautifully.

-Alex
