From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 1 Jul 2018 21:54:49 -0300
Subject: [PATCH v1] ARM: dts: imx6sl-evk: keep sw4 always on
In-Reply-To: <AM3PR04MB131507901BFEE1A5E426EECBF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1529930051-14122-1-git-send-email-yibin.gong@nxp.com>
 <20180701093402.GN4348@dragon>
 <CAOMZO5BjOEGWv2dC-bp0BYHq+PhLssEKic+o7ock8_1Dobd=sQ@mail.gmail.com>
 <AM3PR04MB131507901BFEE1A5E426EECBF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
Message-ID: <CAOMZO5D8tjnjbwMdLGd7KF7_4PwqRWX8XH8kdcF3-5e-r2YQEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anson,

On Sun, Jul 1, 2018 at 9:53 PM, Anson Huang <anson.huang@nxp.com> wrote:

> Yes, I think we can revert it to avoid breakage. Didn't notice that some
> i.MX platform do NOT have those critical switches always-on.

Ok, thanks for confirming.

I will send a revert patch then.

Thanks
