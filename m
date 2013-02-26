From: olof@lixom.net (Olof Johansson)
Date: Mon, 25 Feb 2013 23:06:43 -0800
Subject: [PATCH] ARM: bcm2835: fix I2C module clock rate
In-Reply-To: <1361511758-5208-1-git-send-email-swarren@wwwdotorg.org>
References: <1361511758-5208-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20130226070643.GB10312@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 21, 2013 at 10:42:38PM -0700, Stephen Warren wrote:
> BCM2835-ARM-Peripherals.pdf states that the I2C module's input clock is
> nominally 150MHz, and that value is currently reflected in bcm2835.dtsi.
> However, practical measurements show that the rate is actually 250MHz,
> and this agrees with various downstream kernels.
> 
> Switch the I2C clock's frequency to 250MHz so that the generated bus
> clock rate is accurate.
> 
> Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
> ---
> This is a bug-fix for 3.9.

Applied.


-Olof
