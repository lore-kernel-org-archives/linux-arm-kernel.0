From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 10 Dec 2013 09:01:42 +0000
Subject: [PATCH v3 09/15] mfd: menelaus: Pass menelaus_chip pointer to
 get/set voltage
In-Reply-To: <1386606085-26838-9-git-send-email-balbi@ti.com>
References: <20131209161422.GC24047@saruman.home>
 <1386606085-26838-1-git-send-email-balbi@ti.com>
 <1386606085-26838-9-git-send-email-balbi@ti.com>
Message-ID: <20131210090142.GR12675@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 09 Dec 2013, Felipe Balbi wrote:

> Those functions are static and can easily receive a menelaus_chip
> pointer argument.
> 
> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/mfd/menelaus.c | 50 +++++++++++++++++++++++++++-----------------------
>  1 file changed, 27 insertions(+), 23 deletions(-)

I see a theme forming.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
