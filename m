From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 1 Nov 2018 15:14:52 -0300
Subject: [PATCH V3 09/10] dts: fsl: add imx7ulp evk support
In-Reply-To: <VI1PR04MB42220F5E1D5864555F4248DF80CE0@VI1PR04MB4222.eurprd04.prod.outlook.com>
References: <1540996688-23681-1-git-send-email-aisheng.dong@nxp.com>
 <1540996688-23681-10-git-send-email-aisheng.dong@nxp.com>
 <CAOMZO5AZejEAHeB0hQ9T5U2ZJ7MXK=BYm8jY+yyZjbDHo4utGA@mail.gmail.com>
 <VI1PR04MB422242A027713CC447446D6780CE0@VI1PR04MB4222.eurprd04.prod.outlook.com>
 <CAOMZO5BmqQE4wohBwE65f667cxF8LOcSJ=jECDXLADXbK9OEZQ@mail.gmail.com>
 <VI1PR04MB42220F5E1D5864555F4248DF80CE0@VI1PR04MB4222.eurprd04.prod.outlook.com>
Message-ID: <CAOMZO5Air0Mdb_jt=JqJA718yOH5bwrgOe1yQH9YHzazTOrH_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 1, 2018 at 1:21 PM A.s. Dong <aisheng.dong@nxp.com> wrote:

> But for SD card with a single supply, GPIO regulator seems enough to me.
> That's also the using in past years. Are things changed?

Ok, now it clear you are describing the micro SD port and not the eMMC, so:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
