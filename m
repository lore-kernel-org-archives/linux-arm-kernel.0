From: anson.huang@nxp.com (Anson Huang)
Date: Mon, 4 Jun 2018 01:11:29 +0000
Subject: [PATCH 1/4] clk: imx6q: remove clks_init_on array
In-Reply-To: <CAOMZO5ANz-B-s93+R_xnF0LOux1zTY3E8Ky4KvrZ8EX1ZKmpAQ@mail.gmail.com>
References: <1527994847-2363-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5CmgBsaaegVV9OjdyXv5_O0V9iTS2qYbtuH26qkG2_zrA@mail.gmail.com>
 <2D554312-36F2-4781-899C-8D9F5BD20B46@nxp.com>
 <CAOMZO5ANz-B-s93+R_xnF0LOux1zTY3E8Ky4KvrZ8EX1ZKmpAQ@mail.gmail.com>
Message-ID: <AM3PR04MB1315DA5AC8F4F2AC5425A47BF5670@AM3PR04MB1315.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Fabio

Anson Huang
Best Regards!


> -----Original Message-----
> From: Fabio Estevam [mailto:festevam at gmail.com]
> Sent: Sunday, June 3, 2018 8:54 PM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> <kernel@pengutronix.de>; Fabio Estevam <fabio.estevam@nxp.com>; Michael
> Turquette <mturquette@baylibre.com>; Stephen Boyd <sboyd@kernel.org>;
> dl-linux-imx <linux-imx@nxp.com>; moderated list:ARM/FREESCALE IMX / MXC
> ARM ARCHITECTURE <linux-arm-kernel@lists.infradead.org>; linux-clk
> <linux-clk@vger.kernel.org>; linux-kernel <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH 1/4] clk: imx6q: remove clks_init_on array
> 
> Hi Anson,
> 
> On Sun, Jun 3, 2018 at 9:48 AM, Anson Huang <anson.huang@nxp.com>
> wrote:
> 
> > As I explain in previous mail, busy divider clk type already include the flag
> when registered.
> 
> Ok, then please add this information in the commit log to make the review
> process easier.
 
Thanks for the comments, I improved the commit log in V2 patch set.

Anson.
