From: olof@lixom.net (Olof Johansson)
Date: Mon, 17 Jun 2013 14:51:53 -0700
Subject: [PATCH v5 3/4] ARM: hi3xxx: add board support with device tree
In-Reply-To: <1371459376-25438-4-git-send-email-haojian.zhuang@linaro.org>
References: <1371459376-25438-1-git-send-email-haojian.zhuang@linaro.org>
 <1371459376-25438-4-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20130617215153.GO28497@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 17, 2013 at 04:56:15PM +0800, Haojian Zhuang wrote:
> Add board support with device tree for Hisilicon Hi36xx/Hi37xx platform.
> 
> Changelog:
> v3:
> 1. Remove .map_io() in DT machine descriptor. Since debug_ll_io_init()
> is called by default.
> 2. Remove .init_machine() in DT machine descriptor. Since
> of_platform_populate() is called by default in DT mode.
> 
> v2:
> 1. Remove .init_irq() in DT machine descriptor. Since irqchip_init()
> is called by default in DT mode.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
