From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 17 Jul 2014 12:10:44 +0200
Subject: [PATCH 18/19] ARM: SAMSUNG: Remove remaining legacy code
In-Reply-To: <53C67660.8050003@samsung.com>
References: <1404496099-26708-1-git-send-email-t.figa@samsung.com>
 <1404496099-26708-19-git-send-email-t.figa@samsung.com>
 <1405504062.4408.11.camel@x220> <53C67660.8050003@samsung.com>
Message-ID: <1405591844.4808.30.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz,

On Wed, 2014-07-16 at 14:56 +0200, Tomasz Figa wrote:
> On 16.07.2014 11:47, Paul Bolle wrote: 
> > So a second order effect is that SAMSUNG_GPIO_EXTRA can now be removed.
> > Which implies that SAMSUNG_GPIO_EXTRA64 and SAMSUNG_GPIO_EXTRA128 can
> > also be removed.
> > 
> > Should I submit the trivial patch to do that or is a patch already
> > queued somewhere?
> 
> Please do if you don't mind. That's one more thing I missed.

I got lucky! Commit ab275b132a79 ("ARM: s5p: cut the custom
ARCH_NR_GPIOS definition") was added to next-20140717 which does just
that.

The strange thing is that it is dated "Jun 3 2104". I don't know what
happened there but I have little reason to find that out.

Thanks,


Paul Bolle
