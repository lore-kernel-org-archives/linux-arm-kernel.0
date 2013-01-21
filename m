From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Jan 2013 16:01:33 +0000
Subject: [PATCH v9 05/22] mfd: omap-usb-tll: Clean up clock handling
In-Reply-To: <1358766286-5425-1-git-send-email-rogerq@ti.com>
References: <20130118145906.GE23505@n2100.arm.linux.org.uk>
 <1358766286-5425-1-git-send-email-rogerq@ti.com>
Message-ID: <20130121160133.GP23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 21, 2013 at 01:04:46PM +0200, Roger Quadros wrote:
> Every channel has a functional clock that is similarly named.
> It makes sense to use a for loop to manage these clocks as OMAPs
> can come with up to 3 channels.
> 
> Dynamically allocate and get channel clocks depending on the
> number of clocks avaiable on the platform.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Reviewed-by: Felipe Balbi <balbi@ti.com>

Much better from the clk API usage, thanks.

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
