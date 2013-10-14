From: jg1.han@samsung.com (Jingoo Han)
Date: Mon, 14 Oct 2013 09:33:20 +0900
Subject: [PATCH] ARM: SAMSUNG: remove IRQF_DISABLED
In-Reply-To: <1381548966-5210-1-git-send-email-michael.opdenacker@free-electrons.com>
References: <1381548966-5210-1-git-send-email-michael.opdenacker@free-electrons.com>
Message-ID: <000801cec874$fbc92cb0$f35b8610$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, October 12, 2013 12:36 PM, Michael Opdenacker wrote:
> 
> This patch proposes to remove the use of the IRQF_DISABLED flag
> 
> It's a NOOP since 2.6.35 and it will be removed one day.
> 
> Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>

Reviewed-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> ---
>  arch/arm/mach-s3c24xx/dma.c         | 2 +-
>  arch/arm/mach-s3c24xx/simtec-usb.c  | 3 +--
>  arch/arm/mach-s3c64xx/mach-smartq.c | 2 +-
>  3 files changed, 3 insertions(+), 4 deletions(-)
