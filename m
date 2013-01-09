From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 9 Jan 2013 14:30:34 -0200
Subject: [PATCH 3/4] ARM i.MX53: add dts for the TQ tqma53 module
In-Reply-To: <1357739065-9153-4-git-send-email-s.trumtrar@pengutronix.de>
References: <1357739065-9153-1-git-send-email-s.trumtrar@pengutronix.de>
 <1357739065-9153-4-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <CAOMZO5BXKbjh1J+ms2b4taGaT34xAUM+L3E4FouyZ6tOnQTofg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 9, 2013 at 11:44 AM, Steffen Trumtrar
<s.trumtrar@pengutronix.de> wrote:

> +
> +&wdog1 {
> +       status = "okay";
> +};

This can be removed, since imx53.dtsi already enables the watchdog.
