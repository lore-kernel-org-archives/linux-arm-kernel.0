From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 05 Jul 2016 15:29:30 +0200
Subject: [PATCH 3/4] drivers: reset: Add STM32 reset driver
In-Reply-To: <577B61EA.5080703@st.com>
References: <1467640052-6770-1-git-send-email-gabriel.fernandez@st.com>
 <1467640052-6770-3-git-send-email-gabriel.fernandez@st.com>
 <1467653810.2224.77.camel@pengutronix.de> <577B61EA.5080703@st.com>
Message-ID: <1467725370.2978.64.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 05.07.2016, 09:29 +0200 schrieb Gabriel Fernandez:
[...]
> >> +static const struct reset_control_ops stm32_reset_ops = {
> >> +	.assert		= stm32_reset_assert,
> >> +	.deassert	= stm32_reset_deassert,
> > Are the registers not readable, or did you choose not to
> > implement .status on purpose?
> We choose to not implement.

Ok. Because of size issues or just because you don't need them in any of
your drivers?

regards
Philipp
