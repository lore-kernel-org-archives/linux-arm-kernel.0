From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 11 Aug 2014 14:56:45 +0100
Subject: [RESEND PATCH 0/6] thermal: sti: Add new Thermal driver
In-Reply-To: <20140721101306.GW30888@lee--X1>
References: <20140624092309.GD13803@lee--X1> <20140709120823.GA32573@lee--X1>
 <1404911964.28592.4.camel@rzhang1-toshiba>
 <20140709134646.GB479@lee--X1> <20140714130824.GA3993@lee--X1>
 <1405347277.28592.25.camel@rzhang1-toshiba>
 <20140714142703.GC3993@lee--X1> <20140721091753.GV30888@lee--X1>
 <1405935299.2455.3.camel@rzhang1-toshiba>
 <20140721101306.GW30888@lee--X1>
Message-ID: <20140811135645.GD31769@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 21 Jul 2014, Lee Jones wrote:
> On Mon, 21 Jul 2014, Zhang Rui wrote:
> > On Mon, 2014-07-21 at 10:17 +0100, Lee Jones wrote:
> > > On Mon, 14 Jul 2014, Lee Jones wrote:
> > > > On Mon, 14 Jul 2014, Zhang Rui wrote:
> > > > > On Mon, 2014-07-14 at 14:08 +0100, Lee Jones wrote:
> > > > > > On Wed, 09 Jul 2014, Lee Jones wrote:
> > > > > > > On Wed, 09 Jul 2014, Zhang Rui wrote:
> > > > > > > > On Wed, 2014-07-09 at 13:08 +0100, Lee Jones wrote:
> > > > > > > > > On Tue, 24 Jun 2014, Lee Jones wrote:
> > > > > > > > > 
> > > > > > > > > > > I'm re-sending this set, as one of the maintainers' email addresses
> > > > > > > > > > > is incorrect in the MAINTAINERS file.
> > > > > > > > > > > 
> > > > > > > > > > > This patchset adds full support for 2 types of Thermal Controllers
> > > > > > > > > > > produced by STMicroelectronics.  One is a more traditional memory
> > > > > > > > > > > mapped variant, the other is controlled solely by system configuration
> > > > > > > > > > > registers.
> > > > > > > > > > 
> > > > > > > > > > Any thing from the Thermal guys? Has this set fallen through the gaps?
> > > > > > > > > 
> > > > > > > > > Anything at all?  It's been well over a month now.
> > > > > > > > > 
> > > > > > > > Well, for the soc thermal drivers, I'd prefer to take them via Eduardo,
> > > > > > > > but as we didn't get any feedback from Eduardo, I will take them.
> > > > > > > 
> > > > > > > Thanks Rui.
> > > > > > > 
> > > > > > > So have you taken all 4 "thermal: sti: *" patches?
> > > > > > 
> > > > > > Have you taken these yet?
> > > > > 
> > > > > Not yet. will do tomorrow.
> > > 
> > > I waited 7 days and still don't see them?
> > > 
> > Done, they're in my local tree and I forgot to push them.
> > thanks for the reminder.
> 
> Thanks dude.

Hi Rui,

Do you know when you will send your pull-request?

We are half way through the merge window and I don't see any new
Thermal patches?

Kind regards,
Lee

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
