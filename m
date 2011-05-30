From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 30 May 2011 14:41:08 +0200
Subject: [PATCH v2] ARM: smp_twd: Reconfigure clockevents after cpufreq
	change
In-Reply-To: <1305851091-10096-1-git-send-email-ccross@android.com>
References: <1305851091-10096-1-git-send-email-ccross@android.com>
Message-ID: <BANLkTinLXGupiadbE_mX=EeS_g+7oKvzkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/5/20 Colin Cross <ccross@android.com>:

> The localtimer's clock changes with the cpu clock. ?After a
> cpufreq transition, update the clockevent's frequency and
> reprogram the next clock event.

Colin can you put this into Russells patch tracker with all the ACKs?

Actually I think this is -rc material since it fixes a real bug for us
atleast, maybe that's just me.

Yours,
Linus Walleij
