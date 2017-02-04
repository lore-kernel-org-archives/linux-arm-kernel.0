From: olof@lixom.net (Olof Johansson)
Date: Fri, 3 Feb 2017 16:08:32 -0800
Subject: [PATCH] clocksource: arm_arch_timer: print timer value at init
 time
In-Reply-To: <1482169657-15773-1-git-send-email-olof@lixom.net>
References: <1482169657-15773-1-git-send-email-olof@lixom.net>
Message-ID: <CAOesGMjzxw9LGmLVV_5drH1snwo_a+pwCi+rD6m46nJOumGmQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 19, 2016 at 9:47 AM, Olof Johansson <olof@lixom.net> wrote:
> This is useful to get an indication of how much time we spent in firmware.
>
> It's not guaranteed that the timer started at 0 on reset, so it's just
> an approximation, and might very well be invalid on some systems. But
> it's still a useful metric to have access to.
>
> Signed-off-by: Olof Johansson <olof@lixom.net>

Friendly ping. Would be nice to see this land in 4.11.


Thanks,

-Olof
