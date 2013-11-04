From: jg1.han@samsung.com (Jingoo Han)
Date: Mon, 04 Nov 2013 18:56:57 +0900
Subject: [PATCH] ARM: SAMSUNG: remove unused SAMSUNG_GPIOLIB_4BIT Kconfig
 parameter
In-Reply-To: <1383558685-5343-1-git-send-email-michael.opdenacker@free-electrons.com>
References: <1383558685-5343-1-git-send-email-michael.opdenacker@free-electrons.com>
Message-ID: <000001ced944$33386320$99a92960$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, November 04, 2013 6:51 PM, Michael Opdenacker wrote:
> 
> This removes the SAMSUNG_GPIOLIB_4BIT Kconfig parameter,
> which was no longer used anywhere in the source code
> and Makefiles.
> 
> Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>

It looks good.
Reviewed-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> ---
>  arch/arm/Kconfig              | 1 -
>  arch/arm/plat-samsung/Kconfig | 8 --------
>  2 files changed, 9 deletions(-)
