From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 5 Apr 2018 11:09:43 +0200
Subject: [GIT PULL] DaVinci SoC update fixes for v4.17
In-Reply-To: <7f22cb95-13fa-7158-1cb1-b644e3c4e660@ti.com>
References: <7f22cb95-13fa-7158-1cb1-b644e3c4e660@ti.com>
Message-ID: <CAK8P3a1Xa4MLrMVZdiuAk7EsuS3dF92+8CQk3ra5kDiWXS3AuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 29, 2018 at 10:08 AM, Sekhar Nori <nsekhar@ti.com> wrote:
> The following changes since commit 96c081735d5197d9d4fa0b6ce84cffa3bb197474:
>
>   ARM: davinci: move davinci_clk_init() to init_time (2018-02-19 16:25:15 +0530)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.17/soc-2
>
> for you to fetch changes up to f6adc9fd1ff9bbe766cbb68e84a0d97f54a4f436:
>
>   ARM: davinci: da8xx: simplify CFGCHIP regmap_config (2018-03-29 12:19:12 +0530)
>
> ----------------------------------------------------------------
> A fix and a clean-up patch for content previously queued for v4.17.
>
> ----------------------------------------------------------------
> David Lechner (2):
>       ARM: davinci: da8xx: fix oops in USB PHY driver due to stack allocated platform_data
>       ARM: davinci: da8xx: simplify CFGCHIP regmap_config

I missed this earlier but have now applied it to next/soc.

      Arnd
