From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Thu, 8 Dec 2016 14:13:28 -0800
Subject: [PATCH] ARM: keystone: dts: fix netcp clocks and add names
In-Reply-To: <20161208211139.3678-1-grygorii.strashko@ti.com>
References: <20161208211139.3678-1-grygorii.strashko@ti.com>
Message-ID: <94626755-2ef9-960c-d55a-f6c6d5c1adb7@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/8/2016 1:11 PM, Grygorii Strashko wrote:
> From: Murali Karicheri <m-karicheri2@ti.com>
>
> Fix the pa clock to point to the clkpa which has clock rate of 1/3 of PA
> PLL clock and add clock names.
>
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>

Hi Arnd,

Can you please pick this fix as well if possible in your
non critical fixes branch ?

Regards,
Santosh
