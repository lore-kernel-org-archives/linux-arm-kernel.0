From: rajesh.bhagat@nxp.com (Rajesh Bhagat)
Date: Fri, 15 Jul 2016 08:13:26 +0000
Subject: [PATCH v2 1/5] drivers: usb: chipidea: Add qoriq platform driver
In-Reply-To: <20160715071309.GF817@shlinux2>
References: <1468038656-10345-1-git-send-email-rajesh.bhagat@nxp.com>
 <1468038656-10345-2-git-send-email-rajesh.bhagat@nxp.com>
 <20160711064358.GG31647@shlinux2>
 <HE1PR0401MB2331ED4FB7F699A8A1BA0BE6E3300@HE1PR0401MB2331.eurprd04.prod.outlook.com>
 <20160715071309.GF817@shlinux2>
Message-ID: <HE1PR0401MB2331C636FB33E29796CA5868E3330@HE1PR0401MB2331.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Peter Chen [mailto:hzpeterchen at gmail.com]
> Sent: Friday, July 15, 2016 12:43 PM
> To: Rajesh Bhagat <rajesh.bhagat@nxp.com>
> Cc: linux-usb at vger.kernel.org; linux-kernel at vger.kernel.org;
> devicetree at vger.kernel.org; Peter Chen <peter.chen@nxp.com>;
> gregkh at linuxfoundation.org; kishon at ti.com; robh+dt at kernel.org;
> shawnguo at kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v2 1/5] drivers: usb: chipidea: Add qoriq platform driver
> 
> On Tue, Jul 12, 2016 at 03:59:07AM +0000, Rajesh Bhagat wrote:
> > > > +
> > > > +err_clks:
> > > > +	ci_hdrc_qoriq_disable_unprepare_clks(pdev);
> > >
> > > If you have only one clock, it is unnecessary to use dedicated APIs for clock
> operation.
> > >
> >
> > We do have multiple clocks, but currently one is integrated in code.
> > Hence created the APIs for future use.

Hello Peter, 

> 
> If you could not integrate one more clocks, I suggest not creating dedicated API until
> you need in future.
> 

Okay, Will take care in v3. 

Best Regards,
Rajesh Bhagat 

> --
> 
> Best Regards,
> Peter Chen
