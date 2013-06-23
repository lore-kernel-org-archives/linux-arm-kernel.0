From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 23 Jun 2013 18:50:03 -0300
Subject: [PATCH v3 1/5] drivers: bus: imx-weim: Remove private driver data
In-Reply-To: <20130623192303.GO32299@pengutronix.de>
References: <1371973698-16150-1-git-send-email-shc_work@mail.ru>
 <20130623192303.GO32299@pengutronix.de>
Message-ID: <CAOMZO5CN2NybQJ27p18R5z0yOUsse5Y4OwRCFn+E9HTTHy2sOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 23, 2013 at 4:23 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:

> I don't know how others see it, but I would keep the private data now
> that it's there already. We don't know what it's good for in the future
> and it doesn't hurt.

I agree with you, Sascha.
