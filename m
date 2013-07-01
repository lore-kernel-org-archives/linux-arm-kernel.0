From: B37400@freescale.com (Singh Sandeep-B37400)
Date: Mon, 1 Jul 2013 04:59:18 +0000
Subject: [1/4] Device tree entry for Freescale TDM controller
In-Reply-To: <20130628221545.GA9357@home.buserror.net>
References: <1362655668-26721-1-git-send-email-Sandeep@freescale.com>
 <20130628221545.GA9357@home.buserror.net>
Message-ID: <3F1D9DCAAB49B94D88DBE05911FA4E6E070D48EC@039-SN1MPN1-001.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Wood Scott-B07421
> Sent: 29 June 2013 03:46
> To: Singh Sandeep-B37400
> Cc: linuxppc-dev at lists.ozlabs.org; linux-arm-kernel at lists.infradead.org;
> Aggrwal Poonam-B10812
> Subject: Re: [1/4] Device tree entry for Freescale TDM controller
> 
> On Thu, Mar 07, 2013 at 04:57:45PM +0530, Sandeep Singh wrote:
> > +tdm at 16000 {
> > +	compatible = "fsl,tdm1.0";
> > +	reg = <0x16000 0x200 0x2c000 0x2000>;
> > +	clock-frequency = <0>;
> > +	tdm_tx_clk = <2048000>;
> > +	interrupts = <62 8 0 0>;
> > +	fsl,max-time-slots = <128>;
> > +};
> 
> tdm_tx_clk isn't in the binding (and should be named fsl,tdm-tx-clk if it
> is meant to be here at all).

I will add it in the binding.

Thanks,
Sandeep
> 
> -Scott
