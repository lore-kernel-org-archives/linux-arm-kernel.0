From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 29 Aug 2016 22:29:12 +0800
Subject: [PATCH v2] ARM: imx: use IS_ENABLED() instead of checking for
 built-in or module
In-Reply-To: <1472465524-2374-1-git-send-email-javier@osg.samsung.com>
References: <1472465524-2374-1-git-send-email-javier@osg.samsung.com>
Message-ID: <20160829142911.GT30790@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2016 at 12:12:04PM +0200, Javier Martinez Canillas wrote:
> The IS_ENABLED() macro checks if a Kconfig symbol has been enabled either
> built-in or as a module, use that macro instead of open coding the same.
> 
> Using the macro makes the code more readable by helping abstract away some
> of the Kconfig built-in and module enable details.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Applied, thanks.
