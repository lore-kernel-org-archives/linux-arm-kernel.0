From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 9 Jan 2012 11:51:51 +0300
Subject: [PATCH] ARM: PXA: Zipit Z2: Fix oops in z2_power_off
In-Reply-To: <201201090058.44041.marek.vasut@gmail.com>
References: <1326011616-3546-1-git-send-email-anarsoul@gmail.com>
 <201201081140.29275.marek.vasut@gmail.com>
 <CA+E=qVcJtT9L0kkRT2NAw1Sefeje9vRjqCSLQbm=Z=X4AO+Law@mail.gmail.com>
 <201201090058.44041.marek.vasut@gmail.com>
Message-ID: <CA+E=qVcYsa487rSAa48ZrJU64f1z1bbNXgjDnq23Y45WqwiXMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/1/9 Marek Vasut <marek.vasut@gmail.com>:

>> Nope, it does not work. Looks like device disables power on memory in
>> deepsleep.
>
> Why?

In deepsleep PXA27x deasserts SYS_EN pin, and looks like when it's
deasserted there's no power on SDRAM (on Zipit). Just guess.
