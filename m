From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 17 Feb 2016 11:48:38 +0100
Subject: [PATCH 0/7] fix IS_ERR_VALUE usage
In-Reply-To: <1455546925-22119-1-git-send-email-a.hajda@samsung.com>
References: <1455546925-22119-1-git-send-email-a.hajda@samsung.com>
Message-ID: <7443859.JK6ybmGO1A@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 15 February 2016 15:35:18 Andrzej Hajda wrote:
> 
> Andrzej Hajda (7):
>   netfilter: fix IS_ERR_VALUE usage
>   MIPS: module: fix incorrect IS_ERR_VALUE macro usages
>   drivers: char: mem: fix IS_ERROR_VALUE usage
>   atmel-isi: fix IS_ERR_VALUE usage
>   serial: clps711x: fix IS_ERR_VALUE usage
>   fbdev: exynos: fix IS_ERR_VALUE usage
>   usb: gadget: fsl_qe_udc: fix IS_ERR_VALUE usage
> 

Can you Cc me the next time on all of the patches? I only got
three of them this time.

	Arnd
