From: voice.shen@atmel.com (Bo Shen)
Date: Tue, 25 Jun 2013 13:05:59 +0800
Subject: [PATCH 1/2] ARM: at91/PMC: fix at91sam9n12 USB FS init
In-Reply-To: <1372091879-28459-1-git-send-email-nicolas.ferre@atmel.com>
References: <1372091879-28459-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <51C92537.2070304@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On 06/25/2013 12:37 AM, Nicolas Ferre wrote:
> at91sam9n12 has Full-speed only USB. So we should add
> it to the list in at91_pllb_usbfs_clock_init() function.
> Moreover, at91sam9n12 has an unusual PMC in the sense that it
> has a PLLB but also has a USB clock register.
>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>   arch/arm/mach-at91/clock.c                 | 25 +++++++++++++++++++++----
>   arch/arm/mach-at91/include/mach/at91_pmc.h |  3 +++
>   2 files changed, 24 insertions(+), 4 deletions(-)

For this series, test on at91sam9n12ek board, all are OK.

Tested-by: Bo Shen <voice.shen@atmel.com>

Best Regards,
Bo Shen
