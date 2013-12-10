From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 10 Dec 2013 08:57:01 +0000
Subject: [PATCH v3 07/15] mfd: menelaus: Limit the usage of the_menelaus
In-Reply-To: <1386606085-26838-7-git-send-email-balbi@ti.com>
References: <20131209161422.GC24047@saruman.home>
 <1386606085-26838-1-git-send-email-balbi@ti.com>
 <1386606085-26838-7-git-send-email-balbi@ti.com>
Message-ID: <20131210085701.GP12675@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Pass a menelaus_chip pointer as argument to most functions so we can
> minimize the usage of the global the_menelaus pointer.
> 
> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/mfd/menelaus.c | 265 ++++++++++++++++++++++++++-----------------------
>  1 file changed, 142 insertions(+), 123 deletions(-)

How is this different from patch 6?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
