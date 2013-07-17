From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 17 Jul 2013 12:23:29 +0100
Subject: [PATCH 2/3] mfd: sec: Add clock cell for s2mps11
In-Reply-To: <1373197462-4033-3-git-send-email-yadi.brar@samsung.com>
References: <1373197462-4033-1-git-send-email-yadi.brar@samsung.com>
 <1373197462-4033-3-git-send-email-yadi.brar@samsung.com>
Message-ID: <20130717112329.GC3336@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 07 Jul 2013, Yadwinder Singh Brar wrote:

> This patch adds clock to list of mfd cells for s2mps11 and DT documentation
> for clock part.
> 
> Signed-off-by: Yadwinder Singh Brar <yadi.brar@samsung.com>
> ---
>  Documentation/devicetree/bindings/mfd/s2mps11.txt |   20 ++++++++++++++++++++
>  drivers/mfd/sec-core.c                            |    4 +++-
>  2 files changed, 23 insertions(+), 1 deletions(-)

For drivers/mfd/sec-core.c:

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
