From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Sep 2012 07:56:10 +0000
Subject: [PATCH V4 5/5] ARM: bcm2835: instantiate console UART
In-Reply-To: <1347597684-30805-5-git-send-email-swarren@wwwdotorg.org>
References: <1347597684-30805-1-git-send-email-swarren@wwwdotorg.org>
 <1347597684-30805-5-git-send-email-swarren@wwwdotorg.org>
Message-ID: <201209140756.10532.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 14 September 2012, Stephen Warren wrote:
> From: Simon Arlott <simon@fire.lp0.eu>
> 
> This patch was extracted from git://github.com/lp0/linux.git branch
> rpi-split as of 2012/09/08, and modified as follows:
> 
> * s/bcm2708/bcm2835/.
> * Modified device tree vendor prefix.
> * Modified UART DT node to use a unit-address to create unique UART node
>   names, rather than using non-type names "uart0" and "uart1".
>   Note that UART 1 (the Broadcom "mini UART") is not yet present, but
>   I'm naming the DT node in anticipation that it will be added.
> 
> Signed-off-by: Chris Boot <bootc@bootc.net>
> Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
> Signed-off-by: Dom Cobley <popcornmix@gmail.com>
> Signed-off-by: Dom Cobley <dc4@broadcom.com>
> Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
