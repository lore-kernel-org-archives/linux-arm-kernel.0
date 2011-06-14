From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Jun 2011 08:14:55 +0200
Subject: [PATCH] ARM: smp_twd: Reconfigure clockevents after cpufreq change
In-Reply-To: <4DF6FBBA.7010309@ti.com>
References: <1306919711-30965-1-git-send-email-linus.walleij@stericsson.com>
	<BANLkTikEx0+SpwiWHqLNcs0oaLoN4LccHQ@mail.gmail.com>
	<BANLkTik8sz+JQE1nTcEvZLo5PynwK0+zZA@mail.gmail.com>
	<4DF6FBBA.7010309@ti.com>
Message-ID: <BANLkTin7DGz4P1J4k0LV8oxFTkBPJwuX9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/6/14 Santosh Shilimkar <santosh.shilimkar@ti.com>:

> That should be taken care by
> "smp_call_function_single(freqs->cpu, )" with notifier
> being called with all the available CPU's in the mask.

Ah! I see now.

> Did you see any issue with this patch on your platform ?

No, I don't think so, I think we saw the problem on an
earlier version that didn't use smp_call_function_single().

Thanks,
Linus Walleij
