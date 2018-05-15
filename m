From: olof@lixom.net (Olof Johansson)
Date: Tue, 15 May 2018 13:43:37 -0700
Subject: [GIT PULL] ARM: mediatek: soc driver updates for v4.18
In-Reply-To: <bd033549-4998-e376-eb92-16111ec71a07@gmail.com>
References: <bd033549-4998-e376-eb92-16111ec71a07@gmail.com>
Message-ID: <20180515204337.5ymnsofo35a64yxz@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2018 at 01:32:49PM +0200, Matthias Brugger wrote:
> Hi Arnd and Olof,
> 
> Below the commits for mediatek soc drivers.
> Please beware that we need the regmap-ktime-fix [1] from Mark Browns static tag.
> I merged that into my branch, but I wanted to let you know, so that you don't
> hit any breakage when pulling in my branch.

Great, and thanks for mentioning it.

> 
> Regards,
> Matthias
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git
> tags/regmap-ktime-fix
> 
> ---
> 
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
> 
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/
> tags/v4.17-next-soc
> 
> for you to fetch changes up to 0afd32c6bb59e41b6692dec4473efaffffcad67b:
> 
>   Merge commit 'f15cd6d99198e9c15229aefec639a34a6e8174c6' into
> v.4.17-next/soc-test (2018-05-14 12:22:03 +0200)

Merged into next/drivers. Thanks!


-Olof
