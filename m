From: olof@lixom.net (Olof Johansson)
Date: Sun, 15 Apr 2012 11:23:02 -0700
Subject: [GIT PULL] i.MX cleanup patches for next
In-Reply-To: <20120411084403.GN3852@pengutronix.de>
References: <20120411084403.GN3852@pengutronix.de>
Message-ID: <CAOesGMhk9tGokNwy1kdFDB+G08OYEEq9Uf1Qu=K=T8ufick2ag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


On Wed, Apr 11, 2012 at 1:44 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> Hi Arnd, Olof,
>
> Please pull the following i.MX cleanup patches for next.
>
> Sascha
>
> The following changes since commit dd775ae2549217d3ae09363e3edb305d0fa19928:
>
> ?Linux 3.4-rc1 (2012-03-31 16:24:09 -0700)
>
> are available in the git repository at:
>
> ?git://git.pengutronix.de/git/imx/linux-2.6.git tags/imx-cleanup-20120411
>
> for you to fetch changes up to b0843e814737756a38003afe663a626653b66f58:
>
> ?efikamx: match machine descriptions with legacy (2012-04-02 11:20:38 +0200)
>
> ----------------------------------------------------------------
> i.MX misc cleanups
>
> ----------------------------------------------------------------
> Hector Oron (1):
> ? ? ?efikamx: match machine descriptions with legacy
>
> Uwe Kleine-K?nig (1):
> ? ? ?ARM: imx/mx21ads: remove unneeded cast

Same comment as on the other pull request regarding prefix on the efikamx patch.

Also, no need to date the tags -- the tag itself contains the date
(Linus has been complaining to people who add redundant data to the
tag contents when they send tags to him).

Branch contents otherwise looks OK, so respin and send a fresh pull
request and we'll merge it in.


-Olof
