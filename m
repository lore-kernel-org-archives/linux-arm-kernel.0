From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 16 Jan 2014 14:22:53 -0800
Subject: [GIT PULL] DaVinci watchdog change for v3.14
In-Reply-To: <52CE8B05.2040800@ti.com> (Sekhar Nori's message of "Thu, 9 Jan
 2014 17:11:57 +0530")
References: <52CE8B05.2040800@ti.com>
Message-ID: <878uufo9c2.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sekhar Nori <nsekhar@ti.com> writes:

> Hi Arnd, Olof, Kevin,
>
> Can you please pull the following patch. It has been acked by Wim.
> There are some other davinci_wdt.c patches Wim has queued in his
> tree, but a test merge of this patch with latest linux-next does
> not throw any conflicts.
>
> Thanks,
> Sekhar
>
> The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:
>
>   Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v3.14/watchdog
>
> for you to fetch changes up to 843748123d95ae77a489b41f2f193e8502fc7ea8:
>
>   watchdog: davinci: rename platform driver to davinci-wdt (2014-01-09 16:48:31 +0530)
>
> ----------------------------------------------------------------
> This patch updates the davinci watchdog
> platform device name from generic "watchdog"
> to something more specific.
>
> ----------------------------------------------------------------

Pulled into next/drivers,

Thanks,

Kevin
