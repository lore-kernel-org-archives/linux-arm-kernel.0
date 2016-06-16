From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 16 Jun 2016 10:00:47 +0800
Subject: [PATCH v2 3/6] i.MX: system.c: Replace magic numbers
In-Reply-To: <1465954193-5894-4-git-send-email-andrew.smirnov@gmail.com>
References: <1465954193-5894-1-git-send-email-andrew.smirnov@gmail.com>
 <1465954193-5894-4-git-send-email-andrew.smirnov@gmail.com>
Message-ID: <20160616020047.GS20243@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 14, 2016 at 06:29:50PM -0700, Andrey Smirnov wrote:
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  arch/arm/include/asm/hardware/cache-l2x0.h | 1 +

As Uwe already pointed out, it's not necessary to change this file.

>  arch/arm/mach-imx/system.c                 | 5 ++++-
>  arch/arm/mm/cache-l2x0.c                   | 6 ++++--

I suggest you put the changes on cache-l2x0.c into a separate patch and
send it to Russell.

Shawn

>  3 files changed, 9 insertions(+), 3 deletions(-)
