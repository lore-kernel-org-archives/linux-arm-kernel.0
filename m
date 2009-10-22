From: rpurdie@rpsys.net (Richard Purdie)
Date: Thu, 22 Oct 2009 23:43:19 +0100
Subject: spitz backlight: fix brightness limiting
In-Reply-To: <f17812d70910211320s29d3aaa5tad3206df1e99e03b@mail.gmail.com>
References: <20091019213751.GC1482@ucw.cz>
	<f17812d70910211320s29d3aaa5tad3206df1e99e03b@mail.gmail.com>
Message-ID: <1256251399.23211.164.camel@dax.rpnet.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2009-10-22 at 04:20 +0800, Eric Miao wrote:
> It's a little bit weird it's called 'limit_mask' when I first converted it
> to a spi driver. There must be some reasons, Richard, you've got
> any ideas?

Its a historical artifact that once worked through some bitfield magic
but probably stopped working when we increased the range of values the
backlight could accept and we didn't notice the limiting problem.

I'll happily take a patch to fix that.

Cheers,

Richard
