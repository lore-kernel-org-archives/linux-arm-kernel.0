From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sun, 8 Jan 2012 12:51:30 +0300
Subject: [PATCH] ARM: PXA: Zipit Z2: Fix oops in z2_power_off
In-Reply-To: <201201080956.51789.marek.vasut@gmail.com>
References: <1326011616-3546-1-git-send-email-anarsoul@gmail.com>
 <201201080956.51789.marek.vasut@gmail.com>
Message-ID: <CA+E=qVfYMwV_TuAdaDAZVfQfcx5-g-JEr1tUQsuwBcPpvCav+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/1/8 Marek Vasut <marek.vasut@gmail.com>:

> That's why I said this patch (suspend the device to make it feel like powerdown)
> is bullshit in the first place.

Marek, 'deepsleep' suspend on Z2 is a way to save battery power for
monthes. I blew the dust off my Z2 recently (did not touch it for
~2monthes), it was in fake poweroff (deepsleep), and battery is still
charged (not full however). I believe it can't be achieved with
'sleep' suspend.
I agree that it looks weird, but it's hardware bizzarity. Btw, do you
have suggestions how to make it clean?

Vasily.
