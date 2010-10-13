From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 13 Oct 2010 17:48:48 +0900
Subject: [PATCH 1/2] S3C64XX: Ensure samsung_keypad_cfg_gpio() is
	prototyped
In-Reply-To: <20101013081954.GC6424@rakim.wolfsonmicro.main>
References: <1286904195-1534-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<002701cb6aae$af084680$0d18d380$%kim@samsung.com>
	<20101013081954.GC6424@rakim.wolfsonmicro.main>
Message-ID: <003101cb6ab3$753ca4f0$5fb5eed0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> On Wed, Oct 13, 2010 at 05:14:37PM +0900, Kukjin Kim wrote:
> > Mark Brown wrote:
> 
> > > Since it's exported we should make sure we're using the prototype
> > > others see.
> 
> > Hmm...I'm not sure that we need really this. Of course, it can be
helpful.
> > But if so, we have to apply this policy/rule to all of ours...but I
think we
> > don't need it now.
> 
> sparse warns about this issue so fixing issues like this is required to
> get a clean build for sparse users (I do pretty much all my builds with
> sparse).  I am sending fixes for everything I build, though obviously I
> don't have access to all Samsung systems, and it does make life easier
> when doing updates on the arch code.

You mean following?
arch/arm/mach-s3c64xx/setup-keypad.c:16:6: warning: symbol
'samsung_keypad_cfg_gpio' was not declared. Should it be static?

I didn't check sparse :-(
Ok...Ben seems to be busy now...so will apply in my tree.
And I will also fix it our Samsung stuff.

Ben, if any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
