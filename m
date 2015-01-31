From: airlied@gmail.com (Dave Airlie)
Date: Sat, 31 Jan 2015 10:13:49 +1000
Subject: [PATCH 0/5] drm: add missing dependencies
In-Reply-To: <1422452889-415782-1-git-send-email-arnd@arndb.de>
References: <1422452889-415782-1-git-send-email-arnd@arndb.de>
Message-ID: <CAPM=9typDPKouFxcO-wA5f1mPG5qwr1+vbATAT9KisXx+W45og@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 January 2015 at 23:48, Arnd Bergmann <arnd@arndb.de> wrote:
> I did lots of randconfig tests over time, which resulted in many patches,
> five of which are for drm. In each of these cases, the Kconfig dependencies
> are incomplete, which can lead to broken builds, and specifying the
> complete dependencies solves it.
>
> The patches are all independent from one another and solve separate
> issues. Please apply.

Thanks Arnd, I've taken these all into drm-next in case any is wondering.

Dave.
