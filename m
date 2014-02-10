From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 10 Feb 2014 11:21:24 +0800
Subject: [PATCH 1/2] ARM: dts: mx53: Remove 'enable-active-low' property
In-Reply-To: <1391605810-3285-1-git-send-email-fabio.estevam@freescale.com>
References: <1391605810-3285-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20140210032122.GD9628@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 05, 2014 at 11:10:09AM -0200, Fabio Estevam wrote:
> 'enable-active-low' is not a valid property for a GPIO controlled regulator.
> 
> According to Documentation/devicetree/bindings/regulator/gpio-regulator.txt:
> 
> "Optional properties:
> ...
> - enable-active-high	: Polarity of GPIO is active high (default is low)."
> 
> ,so the correct way to define an active-low GPIO controlled regulator is to 
> simply not pass 'enable-active-high'.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied both, thanks.
