From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 23 Jun 2015 13:32:24 -0300
Subject: [PATCH] ARM: dts: imx6qdl-sabresd: Allow HDMI and LVDS to work
 simultaneously
In-Reply-To: <1435076593.3155.30.camel@pengutronix.de>
References: <1435075417-28708-1-git-send-email-fabio.estevam@freescale.com>
 <1435076593.3155.30.camel@pengutronix.de>
Message-ID: <CAOMZO5DvURaPsCsksfU2BRPxVwHRi8=z+PJEd2Feuuxuco0+wg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Phillip,

On Tue, Jun 23, 2015 at 1:23 PM, Philipp Zabel <p.zabel@pengutronix.de> wrote:

> Please remember that on i.MX6QDL in general we can't change the LDB
> clock parent without risking a breakdown in the divider:
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/313618.html
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/313619.html
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/313620.html

Yes, I am aware of this issue.

However this patch does not make things worse with this respect.
Instead of changing the LDB parent to PLL5 this patch changes to PLL3
instead.

> Has there been an erratum for this issue yet?

I was told we should see it online within a few weeks. Hopefully we
would be able to revisit your patch series after this happens.

Regards,

Fabio Estevam
