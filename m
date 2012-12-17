From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 17 Dec 2012 18:08:51 -0200
Subject: [PATCH] ARM: mach-imx6q: Do not run error code path in success
 case
In-Reply-To: <20121217200136.GR26326@pengutronix.de>
References: <1355756147-24856-1-git-send-email-fabio.estevam@freescale.com>
 <20121217200136.GR26326@pengutronix.de>
Message-ID: <CAOMZO5CWO3HGGdWecstToA0mmjB2vDsHtSsC3Q0phUG+saJAug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 17, 2012 at 6:01 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:

> Are you sure? It looks to me like it was intentional. The purpose of
> this function is to set the parent/rate correctly. The references to
> the clock are not needed later.

You are right, please disregard this patch.
