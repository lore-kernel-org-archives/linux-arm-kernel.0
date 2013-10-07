From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 07 Oct 2013 13:12:54 -0700
Subject: [PATCH] arm: socfpga: Fix incorrect sdmmc clock name
In-Reply-To: <1376492274.8715.2.camel@linux-builds1>
References: <1376322134-17408-1-git-send-email-dinguyen@altera.com>
 <20130814054810.GF16635@quad.lixom.net>
 <1376492274.8715.2.camel@linux-builds1>
Message-ID: <20131007201254.7445.8105@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Dinh Nguyen (2013-08-14 07:57:54)
> On Tue, 2013-08-13 at 22:48 -0700, Olof Johansson wrote:
> > On Mon, Aug 12, 2013 at 10:42:14AM -0500, dinguyen at altera.com wrote:
> > > From: Dinh Nguyen <dinguyen@altera.com>
> > > 
> > > The SD/MMC clock is named "sdmmc_clk", and NOT "mmc_clk".
> > > 
> > > Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> > > Cc: Mike Turquette <mturquette@linaro.org>
> > > CC: Arnd Bergmann <arnd@arndb.de>
> > > CC: Olof Johansson <olof@lixom.net>
> > > Cc: Pavel Machek <pavel@denx.de>
> > > Cc: linux-arm-kernel at lists.infradead.org
> > 
> > Hi Dinh,
> > 
> > Do you want this applied in fixes for 3.11? If so, can you give me a oneliner
> > on what the impact here is? mmc doesn't come up at all, or something more
> > subtle?
> 
> Hi Olof,
> 
> No, this is go into 3.12 as I am still working on the bindings for
> SD/MMC.
> 
> The oneliner: "The SD/MMC driver was intermittently not coming up
> because it was not able to get the correct clock."

Olof, did you take this? If not I'll put it into my next batch of fixes
for 3.12.

Regards,
Mike

> 
> Thanks,
> Dinh
> > 
> > 
> > -Olof
> >
