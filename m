From: aisheng.dong@nxp.com (A.s. Dong)
Date: Tue, 31 Jul 2018 07:21:56 +0000
Subject: [PATCH v7 3/6] dt-bindings: mailbox: imx-mu: add generic MU
 channel support
In-Reply-To: <CABb+yY04dm_N1Ud2Mhi-g-eFdNVkxJKE8ONOqntZjN_QKwgLcg@mail.gmail.com>
References: <AM0PR04MB42116C756EC78AD12EB254D6802B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <CABb+yY0yn9os6nqH8eUfAr3Q3ev4=TfpTp=5ZDBR7FN67eb-wg@mail.gmail.com>
 <VI1PR04MB4222672B8F7B6AF2B11A4442802A0@VI1PR04MB4222.eurprd04.prod.outlook.com>
 <CABb+yY1EkHk85H72xYoYA3JbQL03+-o3UcRVdA_Zub-Q+D=OHw@mail.gmail.com>
 <VI1PR04MB422216469EE5F3ED8E53A4F1802A0@VI1PR04MB4222.eurprd04.prod.outlook.com>
 <CABb+yY0SfdFr8TMOMosTVb5+LFWqB8nQkKj3ze8usi-s7Cko4g@mail.gmail.com>
 <VI1PR04MB4222B4877B341C0FA07A6A8D802A0@VI1PR04MB4222.eurprd04.prod.outlook.com>
 <CABb+yY1MSSQKZ6BOQXC-x=qy4VZ5HqDBjmh_BJTXSkAm3+P8mA@mail.gmail.com>
 <bf7aca98-7ec8-bcf3-b1a8-d86a7cf28d31@pengutronix.de>
 <CABb+yY3PLcjduxm7uJ9xZpPP2zkcQ5Qngs4PjnhGAXp43QVzFA@mail.gmail.com>
 <20180730144435.srxgohwgdhrmw2rz@pengutronix.de>
 <CABb+yY0sUxGatozwdQVM55z7ACtpK8HCepnfvQNunQ=r5y_kVw@mail.gmail.com>
 <CABb+yY04dm_N1Ud2Mhi-g-eFdNVkxJKE8ONOqntZjN_QKwgLcg@mail.gmail.com>
Message-ID: <AM0PR04MB42118617A7F29C1D7BE59242802E0@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jassi,

> > However, if SCU (in its current form) must be supported. We may need
> > to add the third cell (irq enable or not) or some better way, right
> > now.
> >
> Looking at imx_mu_scu_send_data(), which simply polls on the tx, I think we
> don't even need third cell for scu client. A simple 2-cell, 8 uni-dir channel
> setup should work.

How would you suggest to use for SCU in 2 -cells?

> If I see the scu client driver, I could confirm how it would work.
> 

I've already given a general overview from here:
https://www.spinics.net/lists/arm-kernel/msg669202.html

Do you need me to send the full scu client driver patch for the reference?
If yes, please feel free to let me know.

Regards
Dong Aisheng

> So, lets please do the 8 uni-directional, 2 cells implementation.
> 
> Regards.
