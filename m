From: olof@lixom.net (Olof Johansson)
Date: Sat, 14 Apr 2012 18:04:47 -0700
Subject: [GIT PULL] Samsung fixes-2 for v3.4
In-Reply-To: <4F89A0A5.5030806@samsung.com>
References: <4F89A0A5.5030806@samsung.com>
Message-ID: <CAOesGMhp48Kh+tJ1534G=ze0CEcVBpaPQxVKs8A31difVw9h9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Apr 14, 2012 at 9:07 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Hi Arnd, Olof,
>
> Please pull samsung fixes-2 for v3.4 from following:
> ?git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> v3.4-samsung-fixes-2

Pulled, thanks.

> Most are for fix of build failure :( and warnings.
> If any problems, please let me know.
>
> Note that according to changing the device name for sdhci controllers and
> removing clk_type from sdhci platform_data after v3.4-rc1, need to update
> regarding stuff in samsung arch part so I'm preparing its fix in
> samsung-fixes-3. I will send it next turn.

Looking at your current fixes-3 branch, it's unclear at a quick glance
why the clk_type patch is a bugfix, and especially why it is a
regression fix -- it looks like a cleanup. We're very close to 3.4-rc3
now, so we should only be merging fixes (and ideally only regressions
since 3.3).

So, if you do need it to go into 3.4 please motivate it when you send
the pull request.


Thanks,

-Olof
