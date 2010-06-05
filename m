From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Sat, 05 Jun 2010 21:18:17 +0400
Subject: [PATCHv2 1/3] MTD/pxa: use __devinit for pxa2xx_flash_probe
In-Reply-To: <4C0A13BA.6050700@gmail.com>
References: <4C0A13BA.6050700@gmail.com>
Message-ID: <4C0A86D9.2070106@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wan ZongShun wrote:

> This patch is to use the '__devinit' for pxa2xx_flash_probe.

    Why? Is it hot-pluggable device? I guess not...

> Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>
> Acked-by: Eric Miao <eric.y.miao@gmail.com>

WBR, Sergei
