From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 25 May 2011 23:01:04 +0800
Subject: [PATCH] ASoc: sam9g20_wm8731: use the proper SYSCKL value
In-Reply-To: <1306230676-28688-1-git-send-email-nicolas.ferre@atmel.com>
References: <1306230676-28688-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20110525150103.GB12816@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 24, 2011 at 11:51:16AM +0200, Nicolas Ferre wrote:
> at91sam9g20 is providing master clock to wm8731: not using a crystal but an
> external MCLK. We can avoid conflict and save power using WM8731_SYSCLK_MCLK as
> we do not need oscillator to be powered.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Applied, thanks.
