From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 28 Dec 2014 20:16:24 +0900
Subject: [PATCH v3 3/5] pinctrl: exynos: add exynos5410 SoC specific data
In-Reply-To: <1416695185-5198-1-git-send-email-afaerber@suse.de>
References: <547104D5.4030803@suse.de>
 <1416695185-5198-1-git-send-email-afaerber@suse.de>
Message-ID: <549FE688.1060601@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andreas,

On 23.11.2014 07:26, Andreas F?rber wrote:
> From: Hakjoo Kim <ruppi.kim@hardkernel.com>
>
> Add Samsung EXYNOS5410 SoC specific data to enable pinctrl
> support for all platforms based on EXYNOS5410.
>
> Signed-off-by: Hakjoo Kim <ruppi.kim@hardkernel.com>
> [AF: Rebased onto Exynos5260 and irq_chip consolidation]
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>   v2 -> v3:
>   * Rebased (.svc, .{g,w}eint_{con,mask,pend} fields dropped)
>
>   v1 -> v2:
>   * Filled in Sob from Hakjoo Kim

Any news on this patch? I'd like to ACK it, but apparently it is waiting 
for a rebase.

Sorry for the delay, unfortunately things are a little bit busy on my 
side nowadays.

Best regards,
Tomasz
