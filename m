From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 11 Aug 2011 20:24:19 +0200
Subject: [PATCH 4/4] Move top level platform devices in sysfs to
	/sys/devices/soc/X
In-Reply-To: <20110811152239.GB13745@suse.de>
References: <1312981422-13294-1-git-send-email-lee.jones@linaro.org>
	<1312981422-13294-4-git-send-email-lee.jones@linaro.org>
	<20110810150232.GC7938@suse.de> <4E43C399.1040505@stericsson.com>
	<20110811152239.GB13745@suse.de>
Message-ID: <CAKnu2Mrzi=mPsHjPePWxyr6Pt5FvBnzFq432SezvgtV+_Jh3Ng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/8/11 Greg KH <gregkh@suse.de>:

> Ok, if you get guarantees from anyone using the in-kernel platform soc
> code that this move is acceptable, and you guarantee that no userspace
> tools will break, that's fine. ?But odds are, you are going to break
> something...

Yeah I know, but I strongly suspect that these userspace tools are
created by the same organization that should've consulted me and
the rest of the community about it in the first place, so I'll cope with
it and write patches as I get flamed.

Thanks,
Linus Walleij
