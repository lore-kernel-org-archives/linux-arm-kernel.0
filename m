From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 11 Apr 2012 21:13:24 -0300
Subject: [PATCH 1/3] ARM i.MX27: Add devicetree support
In-Reply-To: <87iph7wu97.fsf@laptop.org>
References: <1330503654-2197-1-git-send-email-s.hauer@pengutronix.de>
 <1330503654-2197-2-git-send-email-s.hauer@pengutronix.de>
 <87lim5zne5.fsf@laptop.org> <20120410091715.GA3852@pengutronix.de>
 <87iph7wu97.fsf@laptop.org>
Message-ID: <CAOMZO5ChBtMnR-MHMGyqn6xnXHAXzzBq0AA0-x7q_uk7zYC5vA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sascha,

On Tue, Apr 10, 2012 at 11:12 AM, Chris Ball <cjb@laptop.org> wrote:

>> Thanks for noting. I assume that irq_domain_add_legacy is the right
>> approach here, just like the other i.MX boards do, right?
>
> Yeah, if you look at Grant's removal patch:
>
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=6b783f7c5dde2648fa0bbe7fc8ac80d78699e67f
>
> .. he converted all of the in-tree uses to irq_domain_add_legacy()
> at the time of removal, so that looks right.

I managed to get mx27pdk booting from dt (thanks Shawn for the tips!)
and I fixed this problem.

Will send the fix soon.
