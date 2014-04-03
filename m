From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 3 Apr 2014 14:33:12 +0800
Subject: [PATCH 75/75] ARM: l2c: imx: remove direct write to power
 control register
In-Reply-To: <E1WTYaQ-0007I4-0D@rmk-PC.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
 <E1WTYaQ-0007I4-0D@rmk-PC.arm.linux.org.uk>
Message-ID: <20140403063310.GG2801@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 28, 2014 at 03:20:50PM +0000, Russell King wrote:
> Now that we handle this in core code, we don't need platforms enabling
> the low power modes directly.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

For patches that I'm on Cc:

Acked-by: Shawn Guo <shawn.guo@linaro.org>
