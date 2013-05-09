From: olof@lixom.net (Olof Johansson)
Date: Thu, 9 May 2013 16:55:33 -0700
Subject: [PATCH 0/2] ARM: tegra: a couple clock bug-fixes
In-Reply-To: <1367874671-11474-1-git-send-email-swarren@wwwdotorg.org>
References: <1367874671-11474-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20130509235533.GA19697@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 06, 2013 at 03:11:09PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Arnd, Olof,
> 
> The following two patches fix a couple issues in the Tegra20 clock driver
> that show up on specific platforms. They were sent a little late for 3.9,
> and I forgot to include them for 3.10 since they weren't reposted:-(

Applied to fixes now, sorry for missing them earlier.

> Patch 1 is clearly a bug-fix. Someone pedantic could argue that patch 2
> is a new feature since it's the last piece to enabling AC'97 support, but
> I'd argue that it's a bug in the clock driver that it didn't support this
> clock when it was first written:-)

For very early -rc we can be a bit more flexible, so this is ok with me at the
moment.

> These patches logically belong to Tegra's for-3.10/clk branch, but feel
> free to apply them where is easiest; it'd be fine to defer them to a post-
> 3.10-rc1 fixes branch too if you want.

Postponed in effect due to missing them earlier.

Btw, since the drivers have moved and most of the churn is completed, fixes
like these really can go straight to Mike Turquette from here on out.


-Olof
