From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 11 Mar 2012 21:35:10 +0000
Subject: [PATCH 4/4] ARM: __io abuse cleanup
In-Reply-To: <1331500100-31351-5-git-send-email-robherring2@gmail.com>
References: <1331500100-31351-1-git-send-email-robherring2@gmail.com>
 <1331500100-31351-5-git-send-email-robherring2@gmail.com>
Message-ID: <201203112135.10240.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 11 March 2012, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Several platforms incorrectly use __io() for casting to 'void __iomem *'.
> This converts all of those uses to use the common IOMEM macro.
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Anton Vorontsov <avorontsov@mvista.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Paul Mundt <lethal@linux-sh.org>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
> Cc: Linus Walleij <linus.walleij@stericsson.com>
> Cc: linux-sh at vger.kernel.org

Acked-by: Arnd Bergmann <arnd@arndb.de>
