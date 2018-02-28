From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Feb 2018 23:28:16 +0100
Subject: [GIT PULL 2/2] Broadcom drivers fixes for 4.16
In-Reply-To: <20180228005130.31856-2-f.fainelli@gmail.com>
References: <20180228005130.31856-1-f.fainelli@gmail.com>
 <20180228005130.31856-2-f.fainelli@gmail.com>
Message-ID: <CAK8P3a29ZuAZYAFHL0PECavND8Ht1u33Lt8TKHaAN4h2VY-PKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 28, 2018 at 1:51 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:
>
>   Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)
>
> are available in the git repository at:
>
>   https://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.16/drivers-fixes
>
> for you to fetch changes up to fee5f1ef6cf76f87d9799596d06979c9e6589f2b:
>
>   memory: brcmstb: dpfe: support new way of passing data from the DCPU (2018-02-23 10:56:59 -0800)
>
> ----------------------------------------------------------------
> This pull request contains Broadcom SoCs drivers fixes for 4.16, please
> pull the following:
>
> - Markus provides two minor fixes to the Broadcom STB DPFE driver, one
>   to properly mask bits, and a second one to use the correct type. The
>   third commit is a consequence of a newer DFPE firmware which would
>   unfortunately crash without appropriate kernel changes.
>

Pulled into fixes, thanks!

      Arnd
