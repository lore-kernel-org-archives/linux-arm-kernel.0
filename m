From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 22 Aug 2013 12:14:49 +0200
Subject: [PATCH 0/4] arm: atmel: enable kernel uncompress info output
In-Reply-To: <1372922202-28606-1-git-send-email-voice.shen@atmel.com>
References: <1372922202-28606-1-git-send-email-voice.shen@atmel.com>
Message-ID: <5215E499.3060403@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/07/2013 09:16, Bo Shen :
> this patch set enable kernel uncompress info output
>    - sama5d3
>    - at91sam9n12

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Whole series integrated in at91-3.12-soc branch.

Thanks, bye,

>
> without this patch set, it won't show following information
> ---8>---
> Uncompressing Linux... done, booting the kernel.
> ---<8---
>
>
> Bo Shen (4):
>    arm: atmel: sama5: add definition for usart base address
>    arm: atmel: include sama5d3.h into hardware.h
>    arm: atmel: sama5: enable kernel uncompress info output
>    arm: atmel: sam9n12: enable kernel uncompress info output
>
>   arch/arm/mach-at91/include/mach/hardware.h   |    1 +
>   arch/arm/mach-at91/include/mach/sama5d3.h    |    8 ++++++++
>   arch/arm/mach-at91/include/mach/uncompress.h |   13 +++++++++++++
>   3 files changed, 22 insertions(+)
>


-- 
Nicolas Ferre
