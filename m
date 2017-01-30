From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Mon, 30 Jan 2017 14:20:13 +0300
Subject: [PATCH v5 3/8] ARM: dts: rockchip: add timer entries to rk3188 SoC
In-Reply-To: <20170130110428.GC2206@mai>
References: <1485260203-14216-1-git-send-email-al.kochet@gmail.com>
 <1485260203-14216-4-git-send-email-al.kochet@gmail.com>
 <20170130110428.GC2206@mai>
Message-ID: <A5940770-B960-4409-8DA4-BE39EF9A6325@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> 30 ???. 2017 ?., ? 14:04, Daniel Lezcano <daniel.lezcano@linaro.org> ???????(?):
> 
> t is up to the RTC to wake up the system from suspend and there is no
> idle state stopping the local timers on these SoCs. So, the rockchip timers
> won't be ever used on the rk3188, right ?

No rockchip timers where used on rk3188 before.

Actually, I don?t know how to test backup timer functionality. rk3228 backup timer is from alive
subsystem. It is unclear from TRM what this mean, I assume that somehow related to CLK
during suspend. So I pick the timer from alive subsystem on rk3188 also.
DT timer configuration where tested: interrupts and IO works.

> This patch should go after the rockchip timer patches


Ok, let me know, when I should send v6. Or may be you change the order of the patches
during merge.

And thank you for fixing commit message for previous patch.
Feel free to tell me than I write something really unclear or incorrect.

Alexander.
