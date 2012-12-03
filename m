From: cjb@laptop.org (Chris Ball)
Date: Mon, 03 Dec 2012 14:14:25 -0500
Subject: [PATCH] mmc: sdhci-imx-esdhc: use more devm_* functions
In-Reply-To: <1353911983-10103-1-git-send-email-shawn.guo@linaro.org> (Shawn
 Guo's message of "Mon, 26 Nov 2012 14:39:43 +0800")
References: <1353911983-10103-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <87txs3hrse.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Mon, Nov 26 2012, Shawn Guo wrote:
> Use devm_kzalloc, devm_gpio_request_one and devm_request_irq to make
> cleanup path simpler.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Thanks, pushed to mmc-next for 3.8.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
