From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 12 Feb 2014 12:07:34 +0800
Subject: [PATCH 4/9] ARM: Select V6K instead of V6 by default for
 multi-platform
In-Reply-To: <1392153119-23248-5-git-send-email-robherring2@gmail.com>
References: <1392153119-23248-1-git-send-email-robherring2@gmail.com>
 <1392153119-23248-5-git-send-email-robherring2@gmail.com>
Message-ID: <20140212040732.GG31484@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 03:11:54PM -0600, Rob Herring wrote:
> From: Rob Herring <robh@kernel.org>
> 
> MULTI_V6 should default to V6K as it is more optimal than V6. Any
> platform which is not V6K should select CPU_V6 which will enable the
> less optimal code paths.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Anton Vorontsov <anton@enomsg.org>
> Cc: Shawn Guo <shawn.guo@linaro.org>
...
>  arch/arm/mach-imx/Kconfig       | 1 -

Acked-by: Shawn Guo <shawn.guo@linaro.org>
