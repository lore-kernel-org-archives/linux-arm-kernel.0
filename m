From: aisheng.dong@nxp.com (A.s. Dong)
Date: Thu, 25 Oct 2018 16:54:57 +0000
Subject: [PATCH V2 6/8] dts: imx: add common imx7ulp dtsi support
In-Reply-To: <CAOMZO5ArziSkimJvKMFPR-RZwWywLmzjpmvAFT9fB0fp_J_YZw@mail.gmail.com>
References: <1540295058-26090-1-git-send-email-aisheng.dong@nxp.com>
 <1540295058-26090-7-git-send-email-aisheng.dong@nxp.com>
 <CAOMZO5ArziSkimJvKMFPR-RZwWywLmzjpmvAFT9fB0fp_J_YZw@mail.gmail.com>
Message-ID: <AM0PR04MB42113E80FC62AE9B1D72ADA580F70@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Fabio Estevam [mailto:festevam at gmail.com]
> Sent: Friday, October 26, 2018 12:44 AM
[...]
> On Tue, Oct 23, 2018 at 8:55 AM A.s. Dong <aisheng.dong@nxp.com> wrote:
> 
> > +               gpio_ptc: gpio at 40ae0000 {
> > +                       compatible = "fsl,vf610-gpio";
> 
> This should be:
> 
> compatible = "fsl,imx7ulp-gpio", "fsl,vf610-gpio";

That's true.
Thanks for reminder.

Regards
Dong Aisheng
