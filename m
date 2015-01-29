From: davem@davemloft.net (David Miller)
Date: Thu, 29 Jan 2015 15:08:59 -0800 (PST)
Subject: [PATCH 0/4] net: driver fixes from arm randconfig builds
In-Reply-To: <1422454504-439085-1-git-send-email-arnd@arndb.de>
References: <1422454504-439085-1-git-send-email-arnd@arndb.de>
Message-ID: <20150129.150859.1312045066060618087.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 28 Jan 2015 15:15:00 +0100

> These four patches are fallout from test builds on ARM. I have a
> few more of them in my backlog but have not yet confirmed them
> to still be valid.
> 
> The first three patches are about incomplete dependencies on
> old drivers. One could backport them to the beginning of time
> in theory, but there is little value since nobody would run into
> these problems.
> 
> The final patch is one I had submitted before together with the
> respective pcmcia patch but forgot to follow up on that. It's
> still a valid but relatively theoretical bug, because the previous
> behavior of the driver was just as broken as what we have in
> mainline.

Series applied, thanks Arnd.
