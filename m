From: daniel@caiaq.de (Daniel Mack)
Date: Thu, 26 Nov 2009 18:51:50 +0100
Subject: [PATCH 16/17] ALSA: ARM: add Raumfeld audio support
In-Reply-To: <20091125132912.GB14045@rakim.wolfsonmicro.main>
References: <1259145751-3331-1-git-send-email-daniel@caiaq.de>
	<1259145751-3331-17-git-send-email-daniel@caiaq.de>
	<20091125110218.GD17420@opensource.wolfsonmicro.com>
	<20091125122436.GI29442@buzzloop.caiaq.de>
	<20091125132912.GB14045@rakim.wolfsonmicro.main>
Message-ID: <20091126175150.GK14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2009 at 01:29:13PM +0000, Mark Brown wrote:
> On Wed, Nov 25, 2009 at 01:24:36PM +0100, Daniel Mack wrote:

> > No, it wasn't.
> 
> There was at least one unrelated driver for a different part - I
> remember the discussion since someone needed to explain to people (Alan
> Cox, I think) that this wasn't an RTC but rather a TDM clock generator.
> 
> >   http://marc.info/?l=linux-i2c&m=122457836326525&w=2
> 
> > Jean Delvare's last comment on this was:
> 
> > > Honestly I don't see any value in this driver. There's nothing you can
> > > do with it that you couldn't already do without it.
> 
> > The driver itself would do the right thing, but I doubt that
> > resubmitting will help much.
> 
> Looking at the thread in the archive I don't see any effort to answer
> Jean's question there - the reply from Jon talks about device tree
> binding which is, as Jean says, pretty much irrelevant to the question:
> 
>    http://marc.info/?l=linux-i2c&m=122465761327694&w=2
> 
> The question seemed to be more about what the driver was supposed to
> accomplish - talking about the functionality is provided by the driver
> once it's bound to the device should address that.

Ok, will probably get back to this later. For now, I left the code where
it was but changed the API to make it clearer. The actual implementation
is in one line only, so I see no urgent need to move it to an own driver
immediately. Let me know if you're fine with the new version I'll post
soon.

Thanks,
Daniel
