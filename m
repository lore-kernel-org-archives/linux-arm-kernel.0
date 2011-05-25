From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 25 May 2011 23:01:14 +0800
Subject: [PATCH] ASoc: wm8731: fix wm8731_check_osc() connected condition
In-Reply-To: <1306230657-28649-1-git-send-email-nicolas.ferre@atmel.com>
References: <1306230657-28649-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20110525150113.GC12816@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 24, 2011 at 11:50:57AM +0200, Nicolas Ferre wrote:
> The crystal oscillator is only enabled if the WM8731_SYSCLK_XTAL master clock
> is specified. Fix the connected() struct snd_soc_dapm_route function to take
> this into account. Oscillator is not enabled on machine that need it otherwise.

Appilied, thanks.
