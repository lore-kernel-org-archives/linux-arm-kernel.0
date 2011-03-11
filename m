From: akpm@linux-foundation.org (Andrew Morton)
Date: Thu, 10 Mar 2011 17:05:08 -0800
Subject: [PATCH] kbuild: reenable section mismatch analysis
In-Reply-To: <AANLkTik7HwLs8Ux=THRy_-ByH4adebHodSLeEgSSqcsH@mail.gmail.com>
References: <20110216200734.GA25184@merkur.ravnborg.org>
	<1298062040-2774-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20110310164100.5af81e3b.akpm@linux-foundation.org>
	<AANLkTik7HwLs8Ux=THRy_-ByH4adebHodSLeEgSSqcsH@mail.gmail.com>
Message-ID: <20110310170508.1a3d431d.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 10 Mar 2011 20:00:54 -0500
Mike Frysinger <vapier.adi@gmail.com> wrote:

> >
> > eaaaargh! __650 lines of crap added to my i386 allmodconfig build output.
> 
> and it's going to keep staying all f-ed up until people start seeing
> this stuff themselves when they write the bad code

That won't work - everyone will either disable the messages or will
train themselves to ignore them.
