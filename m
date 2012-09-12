From: N.Voss@weinmann.de (Voss, Nikolaus)
Date: Wed, 12 Sep 2012 12:39:10 +0200
Subject: [PATCH v3 0/8] i2c: at91: cleanup and dt support
In-Reply-To: <20120912101607.GA2624@pengutronix.de>
References: <1347432137-25058-1-git-send-email-ludovic.desroches@atmel.com>
 <505041EF.5060204@atmel.com> <20120912101607.GA2624@pengutronix.de>
Message-ID: <EF2E73589CA71846A15D0B2CDF79505D090ED36C51@wm021.weinmann.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Wolfram Sang wrote on Wednesday, September 12, 2012 12:16 PM:
> One thing I'd like to make, though. I'd like to squash the following
> patches into one:
> 
> 	drivers/i2c/busses/i2c-at91.c: add new driver
> 	i2c: at91: use managed resources
> 	i2c: at91: add warning about transmission issues for some devices
> 	i2c: at91: use an id table for SoC dependent parameters
> 
> It is especially the last patch I am mostly interested in. The id_table
> approach is what I like, while the original id_entry mechanism looks
> fishy. I'd was good for reviewing to have the patches split like this;
> yet for hitting mainline, I'd prefer to have the driver proper on first
> occasion. I already did the squashing in a test-branch and the result
> looks good to me.
> 
> Nikolaus, Ludovic: Are you fine with this?

Absolutely.

Niko
