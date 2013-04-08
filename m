From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 8 Apr 2013 16:35:05 +0800
Subject: [PATCH v6] video: mxsfb: Introduce regulator support
In-Reply-To: <1365360299-8707-1-git-send-email-festevam@gmail.com>
References: <1365360299-8707-1-git-send-email-festevam@gmail.com>
Message-ID: <20130408083502.GG5047@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 07, 2013 at 03:44:59PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Instead of using a custom binding for retrieving the GPIO that activates the 
> LCD from devicetree, use a standard regulator.
> 
> This approach has the advantage to be more generic. 
> 
> For example: in the case of a board that has a PMIC supplying the LCD voltage, 
> the current approach would not work, as it only searches for a GPIO pin.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.
