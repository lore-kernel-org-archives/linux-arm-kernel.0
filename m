From: davem@davemloft.net (David Miller)
Date: Thu, 28 Jan 2016 16:14:13 -0800 (PST)
Subject: [PATCH 0/9] network driver fixes
In-Reply-To: <1453903507-3427225-1-git-send-email-arnd@arndb.de>
References: <1453903507-3427225-1-git-send-email-arnd@arndb.de>
Message-ID: <20160128.161413.1463071323452305953.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 27 Jan 2016 15:04:50 +0100

> These are all fixes for relatively harmless bugs that showed up
> in my randconfig testing, so they should not be needed for v4.5
> but get merged into net-next.
> 
> I've managed to address all 'uninitialized variable' warnings that
> I get in ARM randconfig kernels now, this series includes the
> last five I got in network drivers. They are often really annoying
> warnings but when we get new ones, they often are about actual
> bugs in corner cases, so I'm trying hard to eliminate the false
> positives here to get people to pay attention to added warnings.
> I've recently tried building with an older gcc and found tons more
> that are all bogus, this series only addresses the ones that
> gcc-5.2 finds.

Arnd I'm expecting a respin of this series to address with the
feedback you've been given.

Thanks.
