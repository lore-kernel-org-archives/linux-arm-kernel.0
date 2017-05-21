From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 21 May 2017 09:59:52 +0800
Subject: [PATCH] ARM: dts: imx7: use 3 PWM cells
In-Reply-To: <20170516074013.3571-1-stefan@agner.ch>
References: <20170516074013.3571-1-stefan@agner.ch>
Message-ID: <20170521015951.GD26102@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 16, 2017 at 12:40:13AM -0700, Stefan Agner wrote:
> The PWM driver has now capability to specify the PWM polarity
> which is e.g. for backlight control. Allow to make use of PWM
> polarity by specifying pwm-cells to be 3 in the base dt.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Applied, thanks.
