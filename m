From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 14 Mar 2012 08:09:22 +0100
Subject: [PATCH v1 2/5] mmc: mxs-mmc: add dt probe support
In-Reply-To: <20120314065512.GB25735@shlinux2.ap.freescale.net>
References: <1331628428-24017-1-git-send-email-b29396@freescale.com>
 <201203140658.25854.marek.vasut@gmail.com>
 <20120314065512.GB25735@shlinux2.ap.freescale.net>
Message-ID: <201203140809.22676.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Dong Aisheng,

> On Wed, Mar 14, 2012 at 01:58:25PM +0800, Marek Vasut wrote:
> > Dear Dong Aisheng,
> > 
> > > Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> 
> ........
> 
> > > +static const struct of_device_id mxs_mmc_dt_ids[] = {
> > > +	{ .compatible = "fsl,imx23-mmc", .data = NULL, },
> > > +	{ .compatible = "fsl,imx28-mmc", .data = NULL, },
> > 
> > Do you really need two distinct ones here?
> 
> Hmm, my original purpose is to put soc difference data in .data
> to remove cpu_is_* function calls in the driver later.
> Do you think if any issue?
> 

Well, what's the difference between the interfaces on mx233 and mx28? Is it 
something that can't be encoded otherwise? I think they're not so different.

Best regards,
Marek Vasut
