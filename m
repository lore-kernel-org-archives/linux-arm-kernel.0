From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 27 May 2013 13:25:24 -0300
Subject: [PATCH v4 8/8] reset: Add driver for gpio-controlled reset pins
In-Reply-To: <1361878774-6382-9-git-send-email-p.zabel@pengutronix.de>
References: <1361878774-6382-1-git-send-email-p.zabel@pengutronix.de>
 <1361878774-6382-9-git-send-email-p.zabel@pengutronix.de>
Message-ID: <CAOMZO5BJ7h=_cqSUG6X25SHTMe5ym1_nToj5P_PMR9bxN+B2Ow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 26, 2013 at 8:39 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> This driver implements a reset controller device that toggles gpios
> connected to reset pins of peripheral ICs. The delay between assertion
> and de-assertion of the reset signal can be configured.
>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Looks good and it is a very useful binding.

Will anyone apply this?

Thanks,

Fabio Estevam
