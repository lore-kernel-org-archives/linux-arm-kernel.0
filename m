From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 14 Nov 2016 13:47:09 -0200
Subject: [PATCH] ARM: dts: imx6q: replace gpio-key,wakeup with
 wakeup-source for Utilite Pro
In-Reply-To: <1479138250-17780-3-git-send-email-sudeep.holla@arm.com>
References: <1479138250-17780-3-git-send-email-sudeep.holla@arm.com>
Message-ID: <CAOMZO5CiMo0vMLa_iYE11WJRSo-an1F1c=ifP4TgFPHa_eSQGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 14, 2016 at 1:44 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> Though the keyboard driver for GPIO buttons(gpio-keys) will continue to
> check for/support the legacy "gpio-key,wakeup" boolean property to
> enable gpio buttons as wakeup source, "wakeup-source" is the new
> standard binding.
>
> This patch replaces the legacy "gpio-key,wakeup" with the unified
> "wakeup-source" property in order to avoid any further copy-paste
> duplication.
>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
