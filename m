From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 30 Jan 2017 10:03:38 -0700
Subject: [PATCH] MAINTAINERS: extend Raspberry Pi entry
In-Reply-To: <b2e1e59a752395314a20e846337cb70cf22f2959.1485720503.git.baruch@tkos.co.il>
References: <b2e1e59a752395314a20e846337cb70cf22f2959.1485720503.git.baruch@tkos.co.il>
Message-ID: <736209d7-5310-ac2f-1ff7-928b978e665e@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/29/2017 01:08 PM, Baruch Siach wrote:
> Add bcm2836 (Raspberry Pi 2) and bcm2837 (Raspberry Pi 3).

> -BROADCOM BCM2835 ARM ARCHITECTURE
> +BROADCOM BCM2835/BCM2836/BCM2837 ARM ARCHITECTURE
...
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rpi/linux-rpi.git

It would make sense to update that too, if Eric isn't using this. 
However, that's a subject for a different patch perhaps.

Acked-by: Stephen Warren <swarren@wwwdotorg.org>
