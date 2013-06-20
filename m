From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 20 Jun 2013 09:47:13 -0300
Subject: [PATCH v2 7/7] drivers: bus: imx-weim: Change compatible string
 for i.MX6Q
In-Reply-To: <20130620080737.GO32299@pengutronix.de>
References: <1371671678-6345-1-git-send-email-shc_work@mail.ru>
 <1371671678-6345-7-git-send-email-shc_work@mail.ru>
 <20130620070959.GE19896@S2101-09.ap.freescale.net>
 <20130620080737.GO32299@pengutronix.de>
Message-ID: <CAOMZO5BQfyd3AdL3AO0aJcuBq8vk0vE+39nOGhF66PeDPMcsww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 20, 2013 at 5:07 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Thu, Jun 20, 2013 at 03:10:01PM +0800, Shawn Guo wrote:

> How about:
>
> +       { .compatible = "fsl,imx6q-weim", .data = &imx50_weim_devtype, },
> +       { .compatible = "fsl,imx50-weim", .data = &imx50_weim_devtype, },

Why don't we just drop the mx50 case, since there is no kernel support for mx50?
