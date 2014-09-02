From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 2 Sep 2014 15:00:26 -0300
Subject: [PATCH 2/2] ARM: dts: imx6x-sdb: Add LCD support
In-Reply-To: <20140902141147.GL3135@dragon>
References: <1409593803-12368-1-git-send-email-fabio.estevam@freescale.com>
 <1409593803-12368-2-git-send-email-fabio.estevam@freescale.com>
 <20140902135036.GJ3135@dragon>
 <CAOMZO5Ct0PiRViQkrQ24ZUCHmaC+UgY1rktmOH+4BY0s99yB-g@mail.gmail.com>
 <20140902141147.GL3135@dragon>
Message-ID: <CAOMZO5CBNAxapXsVpqi_+G_K+JA1fU7E06A7Fc-xbM3Tp=3f-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 2, 2014 at 11:11 AM, Shawn Guo <shawn.guo@freescale.com> wrote:

> I'm not sure why you do not see it, but I do.
>
> [    0.037835] device-tree: Duplicate name in lcdif at 02220000, renamed to "display#1"

I was not grepping correctly, sorry. I can see it now.

> I do not think the warning comes because of "display: display" but the
> fact that lcdif node has a property named "display" and a child node
> named "display" at the same time.

Ok, sent a v2 without the duplicate warning message. Thanks
