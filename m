From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 24 Feb 2016 14:37:05 +0100
Subject: [PATCH 0/2] ARM: dts: rockchip: fix some interrupts on rk3288
In-Reply-To: <1456234860-18832-1-git-send-email-john@metanate.com>
References: <1456234860-18832-1-git-send-email-john@metanate.com>
Message-ID: <2022698.P5dgKXtQhu@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 23. Februar 2016, 13:40:58 schrieb John Keeping:
> None of these are used by drivers so these don't fix any bugs but maybe
> they'll save someone debugging time in the future.
> 
> John Keeping (2):
>   ARM: dts: rockchip: fix MIPI interrupt on rk3288
>   ARM: dts: rockchip: fix audio interrupts on rk3288

applied both to my dts32 branch for 4.6 after verifying against the TRM as 
well.

Thanks for catching these
Heiko
