From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Mon, 12 Mar 2012 23:42:24 +0400
Subject: [PATCH 4/4] ARM: __io abuse cleanup
In-Reply-To: <1331500100-31351-5-git-send-email-robherring2@gmail.com>
References: <1331500100-31351-1-git-send-email-robherring2@gmail.com>
 <1331500100-31351-5-git-send-email-robherring2@gmail.com>
Message-ID: <20120312194224.GB26116@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 11, 2012 at 04:08:20PM -0500, Rob Herring wrote:
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
> ---

For cns3xxx:

Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

Thanks!

-- 
Anton Vorontsov
Email: cbouatmailru at gmail.com
