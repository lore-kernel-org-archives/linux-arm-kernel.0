From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 20 Jun 2011 11:30:30 +0200
Subject: [PATCH] clocksource/arm_smp_twd: handle frequency changes
In-Reply-To: <4DFF0D73.3080604@arm.com>
References: <1308559687-30768-1-git-send-email-linus.walleij@stericsson.com>
	<4DFF0D73.3080604@arm.com>
Message-ID: <BANLkTinxZBeRz8-ar-1tOPifAQg3_CAFvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2011 at 11:05 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:

> Thanks Linus. I'll push this on top of my patch stack, with the below fix:

Thanks Marc, I think you're making Colin happy too :-)

I don't know why that thing could build & boot for me :-/

I've enabled the same fix, put in my cpufreq clock for the
TWD and rebooted, and it works fine.

Yours,
Linus Walleij
