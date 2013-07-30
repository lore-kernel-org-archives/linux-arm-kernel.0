From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 30 Jul 2013 00:45:33 -0300
Subject: [RFC 1/8] gpio: mxc: Use devm_ functions
In-Reply-To: <20130730031436.GE19715@S2101-09.ap.freescale.net>
References: <1374938808-27316-1-git-send-email-mpa@pengutronix.de>
 <1374938808-27316-2-git-send-email-mpa@pengutronix.de>
 <20130730031436.GE19715@S2101-09.ap.freescale.net>
Message-ID: <CAOMZO5Afr5zZLonmHm1PO4L6ed5SJ2K+vywX3Uu1etBTcrryYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 12:14 AM, Shawn Guo <shawn.guo@linaro.org> wrote:

> It can be even cleaner by using devm_ioremap_resource().

I have already sent a patch that converts to devm_ioremap_resource()
and it is already in Linus Walleij's tree.
