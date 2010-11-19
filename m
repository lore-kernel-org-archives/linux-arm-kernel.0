From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Fri, 19 Nov 2010 20:08:48 +0100
Subject: [PATCH] ARM: tegra: timer: Separate clocksource and sched_clock
In-Reply-To: <1290039615-23407-1-git-send-email-ccross@android.com>
References: <1290039615-23407-1-git-send-email-ccross@android.com>
Message-ID: <AANLkTimjJVw3ZA1F5VEJPaJwwK0FyH=XXc+vkau5zzAk@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/11/18 Colin Cross <ccross@android.com>:

> tegra_clocksource_read should not use cnt32_to_63, wrapping is
> already handled in the clocksource code. ?Move the cnt32_to_63
> into the sched_clock function, and replace the use of clocksource
> mult and shift with a multiplication by 1000 to convert us to ns.
>
> Change-Id: Ica1158c3fbed0ba53391f7db61180129a957511d

The Linux kernel does not use Gerrit...

> Signed-off-by: Colin Cross <ccross@android.com>

Apart from that:
Acked-by: Linus Walleij <linus.walleij@stericsson.com>

Yours,
Linus Walleij
