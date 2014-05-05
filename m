From: olof@lixom.net (Olof Johansson)
Date: Mon, 5 May 2014 13:52:51 -0700
Subject: [PATCH] ARM: multi_v7_defconfig: select CONFIG_GPIO_DWAPB
In-Reply-To: <1397724150-14055-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1397724150-14055-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20140505205251.GF27961@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 17, 2014 at 10:42:30AM +0200, Antoine T?nart wrote:
> The newly integrated dwapb gpio driver handles the Berlin SoCs GPIOs.
> Add this driver to the multi_v7_defconfig.
> 
> Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
> ---
>  This patch applies on top of Alexandre's one selecting
>  CONFIG_MACH_BERLIN_BG2Q:
>  https://patchwork.kernel.org/patch/3876171/

Applied.

-Olof
