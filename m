From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 15 Apr 2013 10:32:58 -0600
Subject: [PATCH] ARM: ux500: DT: Rename root node "soc-u9500" into
 "soc-ux500"
In-Reply-To: <1366022492-8701-1-git-send-email-linus.walleij@stericsson.com>
References: <1366022492-8701-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <516C2BBA.2040406@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15/2013 04:41 AM, Linus Walleij wrote:
> From: Gabriel Fernandez <gabriel.fernandez@stericsson.com>
> 
> This root node is used in the whole family of chips, the a9500
> is just one particular instance.

> diff --git a/arch/arm/boot/dts/ccu9540.dts b/arch/arm/boot/dts/ccu9540.dts

> -	soc-u9500 {
> +	soc-ux500 {

Shouldn't this just be "soc" then; nodes are usually named based on type
of object rather than identity.
