From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 6 Jun 2017 18:33:55 +0200
Subject: [PATCH v4 04/28] clocksource: Add Owl timer
In-Reply-To: <20170606005426.26446-5-afaerber@suse.de>
References: <20170606005426.26446-1-afaerber@suse.de>
 <20170606005426.26446-5-afaerber@suse.de>
Message-ID: <20170606163355.GD2345@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 06, 2017 at 02:54:02AM +0200, Andreas F?rber wrote:
> The Actions Semi S500 SoC provides four timers, 2Hz0/1 and 32-bit TIMER0/1.
> 
> Use TIMER0 as clocksource and TIMER1 as clockevents.
> 
> Based on LeMaker linux-actions tree.
> 
> An S500 datasheet can be found on the LeMaker Guitar pages:
> http://www.lemaker.org/product-guitar-download-29.html
> 
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
