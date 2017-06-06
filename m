From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 6 Jun 2017 18:34:53 +0200
Subject: [PATCH v4 05/28] clocksource: owl: Add S900 support
In-Reply-To: <20170606005426.26446-6-afaerber@suse.de>
References: <20170606005426.26446-1-afaerber@suse.de>
 <20170606005426.26446-6-afaerber@suse.de>
Message-ID: <20170606163453.GE2345@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 06, 2017 at 02:54:03AM +0200, Andreas F?rber wrote:
> The Actions Semi S900 SoC provides four 32-bit timers, TIMER0/1/2/3,
> but no 2Hz timers.
> 
> An S900 datasheet can be found in 96Boards documentation:
> https://github.com/96boards/documentation/blob/master/ConsumerEdition/Bubblegum-96/HardwareDocs/SoC_bubblegum96.pdf
> 
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 

 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
