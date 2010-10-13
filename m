From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 13 Oct 2010 09:19:55 +0100
Subject: [PATCH 1/2] S3C64XX: Ensure samsung_keypad_cfg_gpio() is
	prototyped
In-Reply-To: <002701cb6aae$af084680$0d18d380$%kim@samsung.com>
References: <1286904195-1534-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<002701cb6aae$af084680$0d18d380$%kim@samsung.com>
Message-ID: <20101013081954.GC6424@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 13, 2010 at 05:14:37PM +0900, Kukjin Kim wrote:
> Mark Brown wrote:

> > Since it's exported we should make sure we're using the prototype
> > others see.

> Hmm...I'm not sure that we need really this. Of course, it can be helpful.
> But if so, we have to apply this policy/rule to all of ours...but I think we
> don't need it now.

sparse warns about this issue so fixing issues like this is required to
get a clean build for sparse users (I do pretty much all my builds with
sparse).  I am sending fixes for everything I build, though obviously I
don't have access to all Samsung systems, and it does make life easier
when doing updates on the arch code.
