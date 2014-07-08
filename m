From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 08 Jul 2014 13:49:31 +0200
Subject: [PATCH] ARM: Samsung: ADC: Move to
 clk_prepare_enable/clk_disable_unprepare
In-Reply-To: <1404155288-2787-1-git-send-email-anarsoul@gmail.com>
References: <1404155288-2787-1-git-send-email-anarsoul@gmail.com>
Message-ID: <53BBDACB.6090601@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vasily,

On 30.06.2014 21:08, Vasily Khoruzhick wrote:
> Use clk_prepare_enable/clk_disable_unprepare to make the driver
> work properly with common clock framework.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  arch/arm/plat-samsung/adc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

--
Best regards,
Tomasz
