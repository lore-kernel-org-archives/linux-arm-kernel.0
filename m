From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 10 Dec 2013 09:02:29 +0000
Subject: [PATCH v3 10/15] mfd: menelaus: Pass menelaus_chip argument to
 menelaus <-> time helpers
In-Reply-To: <1386606085-26838-10-git-send-email-balbi@ti.com>
References: <20131209161422.GC24047@saruman.home>
 <1386606085-26838-1-git-send-email-balbi@ti.com>
 <1386606085-26838-10-git-send-email-balbi@ti.com>
Message-ID: <20131210090229.GS12675@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 09 Dec 2013, Felipe Balbi wrote:

> time_to_menelaus() and menelaus_to_time() are static and can easily
> receive a struct menelaus_chip pointer argument.
> 
> After this patch, the_menelaus is only used on exported functions which
> are currently being used by board-n8x0.c.
> 
> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/mfd/menelaus.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)

Same.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
