From: markus.mayer@linaro.org (Markus Mayer)
Date: Wed, 20 Nov 2013 10:24:54 -0800
Subject: [PATCH v4 1/2] watchdog: bcm281xx: Watchdog Driver
In-Reply-To: <20131120162721.GB28683@roeck-us.net>
References: <1384888074-19696-1-git-send-email-markus.mayer@linaro.org>
 <1384888074-19696-2-git-send-email-markus.mayer@linaro.org>
 <CAPdLdqmxFnJ9HZa04buh8NecMszEAp11VRU4Q159vZ+=NG9p3A@mail.gmail.com>
 <20131120162721.GB28683@roeck-us.net>
Message-ID: <CAPdLdq=xUjsr1ykTHh3t_Uy9kBkKXbW0gpAmtgiOfj8gC42yeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Hi Markus,
>
> Yes, I noticed when I merged it into my watchdog-next branch.
>
> Reminds me ... v3 had a whitespace problem. I don't recall if you fixed
> that in v4. If you didn't, that might be a better reason to send v5.

That's still there, unfortunately. Trailing space on the first
help-text line in Kconfig:
    Support for the watchdog timer on the following Broadcom BCM281xx

So, I'll generate v5 with that fixed. Do you prefer I also rebase it
right now to whatever current tip is to take care of the merge
conflict?

Thanks,
-Markus

-- 
Markus Mayer
Broadcom Landing Team
