From: jkosina@suse.cz (Jiri Kosina)
Date: Sun, 10 Apr 2011 08:07:45 -0700 (PDT)
Subject: [trivial PATCH 2/2] arm: mach-u300/gpio: Fix mem_region resource
	size miscalculations
In-Reply-To: <AANLkTika-y8bqaXFp008C28wd_YzmcBm2mj5ZLfxSSSy@mail.gmail.com>
References: <cover.1300909445.git.joe@perches.com>
	<798d0aea7272beadf2ee838f7aa27f86cfe7f9ba.1300909446.git.joe@perches.com>
	<AANLkTika-y8bqaXFp008C28wd_YzmcBm2mj5ZLfxSSSy@mail.gmail.com>
Message-ID: <alpine.LNX.2.00.1104081937100.6392@deuxcents.site>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 23 Mar 2011, Linus Walleij wrote:

> 2011/3/23 Joe Perches <joe@perches.com>:
> 
> > Convert off-by-1 r->end - r->start to resource_size(r)
> >
> > Signed-off-by: Joe Perches <joe@perches.com>
> 
> Oh man, there was one of these lurking in my own beloved mach-u300.
> How embarrassing. Thanks for catching!
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

As I don't see it in today's linux-next, I have picked it up. Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
