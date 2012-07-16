From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 16 Jul 2012 22:57:33 +0530
Subject: [PATCH v6 4/7] net, ethernet, davinci_emac: add OF support
In-Reply-To: <1341823456-32297-1-git-send-email-hs@denx.de>
References: <1341823456-32297-1-git-send-email-hs@denx.de>
Message-ID: <50044F05.6060707@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

On 7/9/2012 2:14 PM, Heiko Schocher wrote:
> add of support for the davinci_emac driver.
> 
> Signed-off-by: Heiko Schocher <hs@denx.de>
> Acked-by: Sekhar Nori <nsekhar@ti.com>
> Cc: davinci-linux-open-source at linux.davincidsp.com
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: devicetree-discuss at lists.ozlabs.org
> Cc: netdev at vger.kernel.org
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Wolfgang Denk <wd@denx.de>
> Cc: Anatoly Sivov <mm05@mail.ru>
> Cc: David Miller <davem@davemloft.net>

Can you please consider this patch for v3.6? I tested it on DaVinci
AM18x EVM with and without CONFIG_OF using NFS root.

This patch can be independently queued and does not have any dependencies.

Thanks,
Sekhar
