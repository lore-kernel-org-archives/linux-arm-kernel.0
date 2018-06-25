From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 25 Jun 2018 10:07:41 -0300
Subject: [PATCH 2/2] ARM: imx_v6_v7_defconfig: Select ULPI support
In-Reply-To: <1529931445.9910.15.camel@pengutronix.de>
References: <1529930043-6387-1-git-send-email-festevam@gmail.com>
 <1529930043-6387-2-git-send-email-festevam@gmail.com>
 <1529931445.9910.15.camel@pengutronix.de>
Message-ID: <CAOMZO5DiM5YP=qS6+qS37unS+o+BQbqpkF70g+hyqh=Mv2u+Wg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lucas,

On Mon, Jun 25, 2018 at 9:57 AM, Lucas Stach <l.stach@pengutronix.de> wrote:

> If the kernel hangs without those options, we might want to have a
> check for them in the driver, so it aborts the initialization with a
> big warning if the port is using ULPI mode and those options aren't
> selected.

That's a good idea. Will do as suggested.

Thanks
