From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 07 Mar 2012 15:40:38 +0400
Subject: [PATCH 12/15] watchdog/mpcore_wdt: Add support for WDIOF_CARDRESET
In-Reply-To: <cb4bdf968a4d53eebf8005636fcef5fde8cbebf7.1331115752.git.viresh.kumar@st.com>
References: <cover.1331115751.git.viresh.kumar@st.com>
 <cb4bdf968a4d53eebf8005636fcef5fde8cbebf7.1331115752.git.viresh.kumar@st.com>
Message-ID: <4F574936.3010909@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 07-03-2012 14:27, Viresh Kumar wrote:

> mpcore watchdog can give last boot status, whether we got a watchdog reset or
> not, via bit 0 of TWD_WDOG_RESETSTAT register. This patch adds support to return
> correct status if WDIOC_GETBOOTSTATUS cmd is called with ioctl.

    In the subject you say about another ioclt.

> Signed-off-by: Viresh Kumar<viresh.kumar@st.com>
> ---
>   arch/arm/include/asm/smp_twd.h |    2 ++
>   drivers/watchdog/mpcore_wdt.c  |   10 +++++++++-
>   2 files changed, 11 insertions(+), 1 deletions(-)

WBR, Sergei
