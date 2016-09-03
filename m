From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Sat, 3 Sep 2016 12:47:19 +0200
Subject: [PATCH v2 07/10] reset: stm32: add driver Kconfig option
In-Reply-To: <1472545496-14373-7-git-send-email-p.zabel@pengutronix.de>
References: <1472545496-14373-1-git-send-email-p.zabel@pengutronix.de>
 <1472545496-14373-7-git-send-email-p.zabel@pengutronix.de>
Message-ID: <CALszF6B8Mco__5aSFUssM-q0Ha5ZyNV0f-BuaOqzWp2P-gsMuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-08-30 10:24 GMT+02:00 Philipp Zabel <p.zabel@pengutronix.de>:
> Visible only if COMPILE_TEST is enabled, this allows to include the
> driver in build tests.
>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Gabriel Fernandez <gabriel.fernandez@st.com>
> Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  drivers/reset/Kconfig  | 6 ++++++
>  drivers/reset/Makefile | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)

In line with what we did on other stm32 drivers:
Reviewed-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>

Thanks!
Maxime
