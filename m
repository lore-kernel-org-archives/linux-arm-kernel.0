From: charu@ti.com (Varadarajan, Charulatha)
Date: Fri, 28 Jan 2011 13:26:19 +0530
Subject: [PATCH 1/5] OMAP:board-omap3evm: Change TWL related gpio API's to
	gpio*_cansleep
In-Reply-To: <1295977061-11086-2-git-send-email-hvaibhav@ti.com>
References: <1295977061-11086-1-git-send-email-hvaibhav@ti.com>
	<1295977061-11086-2-git-send-email-hvaibhav@ti.com>
Message-ID: <AANLkTinc2zfjfc5y6pURF-JEiwhK3FV29E+eS0Q-_GmJ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 25, 2011 at 23:07, Vaibhav Hiremath <hvaibhav@ti.com> wrote:
> Since TWL GPIO's can go into sleep, and using normal
> gpio_get/set_value() API will lead to kernel dump (WARN_ON()).
> So replacing standard gpio_get/set_value() to
> gpio_get/set_value_cansleep().
>
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>

Reviewed-by: Charulatha V <charu@ti.com>

> ---
> ?arch/arm/mach-omap2/board-omap3evm.c | ? 12 ++++++------
> ?1 files changed, 6 insertions(+), 6 deletions(-)
>
