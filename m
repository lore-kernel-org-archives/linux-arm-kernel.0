From: semen.protsenko@globallogic.com (Sam Protsenko)
Date: Sat, 24 Jan 2015 22:54:28 +0200
Subject: [PATCH 0/4] defconfigs: cleanup obsolete MTD configs
In-Reply-To: <1422118156.27947.7.camel@x220>
References: <1422117213-3130-1-git-send-email-semen.protsenko@globallogic.com>
 <1422118156.27947.7.camel@x220>
Message-ID: <CAJOTznWHpRh8ysVxwSWyvZL1UAe-G9A64j=M6z0+zPeoycgkDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> That's news for me. I thought they are silently ignored. Do you have an
> example of such a warning?

Not really. It was just assumption. It seems you are right, they are just
ignored silently. But item 2 is still relevant and it was actually confused
me when I tried to figure out MTD configuration for my platform.
Anyway, garbage should be taken out from time to time.

> Seems like the kind of change that can only be reviewed by a script.

Good point. Because these patches were done by script to start with.
Anyway, I reviewed result patches manually to be completely sure.
You can write verifying script though, if you need to, it wouldn't take
more than 2 minutes (it takes one-liner, actually).

> I seem to remember Greg stating that defconfig files are on their way
> out. Did I remember that correctly?

Maybe they are. But they still in place, and why it's so, we should
maintain them up-to-date. Ideally, this kind of work should be done by
someone who introduces changes into Kconfig files. So I just fixed
that oversight.
