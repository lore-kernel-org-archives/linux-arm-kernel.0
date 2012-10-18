From: richardcochran@gmail.com (Richard Cochran)
Date: Thu, 18 Oct 2012 20:44:43 +0200
Subject: Fwd: [PATCH 2/5] ARM: OMAP3+: hwmod: Add AM33XX HWMOD data for
 davinci_mdio
In-Reply-To: <alpine.DEB.2.00.1210180313360.6893@utopia.booyaka.com>
References: <20121017181354.GA2412@netboy.at.omicron.at>
 <alpine.DEB.2.00.1210172337170.30902@utopia.booyaka.com>
 <20121017235045.GB30550@atomide.com>
 <20121018030654.GE2867@netboy.at.omicron.at>
 <alpine.DEB.2.00.1210180313360.6893@utopia.booyaka.com>
Message-ID: <20121018184443.GD2350@netboy.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 18, 2012 at 03:46:15AM +0000, Paul Walmsley wrote:
> 
> Probably the driver was submitted before any SoC integration support was 
> available.  Grepping for 'cpsw' under arch/ turns up only AM33xx.  AM335x 
> didn't have device enumeration support in the mainline kernel until 3.7, 
> via commit a2cfc509bc4eeef9f5c4607b1203f17f22ea2a36 ("ARM: OMAP3+: hwmod: 
> Add AM33XX HWMOD data").  So I don't see how it could have worked with 
> mainline.

...

> But it seems that the CPSW has never worked in the mainline kernel.  So 
> this particular patch is not fixing a regression.  Therefore we shouldn't 
> send it upstream during the -rc time period.  Instead we'll schedule it to 
> be sent a few weeks later, during the 3.8 merge window.

Let's think about this some more:

The driver's commit is from March and is included in v3.4-rc1.

You say it will be working in 3.8, after 3.7 comes out, in about
December.

So how long does it take between merging code and actually getting it
working?

Sorry to harp on this so much, but I try out my patches with the tip
of the appropriate tree before sending them, or when I cannot, at
least I put into the log "compile tested only" or something like that.

Thanks,
Richard
