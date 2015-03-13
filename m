From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 13 Mar 2015 13:43:43 +0800
Subject: [PATCH] ARM: dts: imx25-pinfunc, remove input values for
 pinfuncs without input register
In-Reply-To: <1426172588-4255-1-git-send-email-mpa@pengutronix.de>
References: <1426172588-4255-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20150313054342.GU20455@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 12, 2015 at 04:03:08PM +0100, Markus Pargmann wrote:
> input values are only useful for pin functions which define a input
> register. This patch removes all input values of pin functions which do
> not have an input configuration register.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

Applied, thanks.

In the future, please use ':' instead of ',' as separator in patch
subject.

Shawn
