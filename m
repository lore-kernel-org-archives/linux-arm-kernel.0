From: olof@lixom.net (Olof Johansson)
Date: Sat, 8 Nov 2014 16:33:08 -0800
Subject: [GIT PULL] Broadcom Cygnus SoC platforms changes
In-Reply-To: <20141109002846.GD11947@quad.lixom.net>
References: <1414698612-26216-1-git-send-email-f.fainelli@gmail.com>
 <1414698612-26216-4-git-send-email-f.fainelli@gmail.com>
 <20141109002846.GD11947@quad.lixom.net>
Message-ID: <20141109003308.GE11947@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 08, 2014 at 04:28:46PM -0800, Olof Johansson wrote:
> On Thu, Oct 30, 2014 at 12:50:12PM -0700, Florian Fainelli wrote:
> > The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:
> > 
> >   Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)
> > 
> > are available in the git repository at:
> > 
> >   http://github.com/brcm/linux.git tags/arm-soc/for-3.18/cygnus-platform-v9
> > 
> > for you to fetch changes up to 038aae04d36eff71e0b30a1c3057ec0a05bf9390:
> > 
> >   ARM: mach-bcm: ARCH_BCM_MOBILE: remove one level of menu from Kconfig (2014-10-30 11:39:51 -0700)
> > 
> > ----------------------------------------------------------------
> > This patchset contains initial support for Broadcom's Cygnus SoC based on our
> > iProc architecture. Initial support is minimal and includes just the mach
> > platform code, clock driver, and a basic device tree configuration. Peripheral
> > drivers will be submitted soon, as will device tree configurations for other
> > Cygnus board variants.
> > 
> > These are the platform changes
> 
> Hi,
> 
> Merged into next/soc. Thanks!

Actually, I noticed on the other branch (the maintainers one) that you
haven't signed off on any patches you've applied (you're the committer,
but there's no Signed-off-by line from you). So I dropped this branch
again, please fix that up and send fresh pull requests.

When you do that, you can also fold in the maintainers patch in the platform
branch.


-Olof
