From: olof@lixom.net (Olof Johansson)
Date: Mon, 12 Jan 2015 18:13:47 -0800
Subject: [GIT PULL] CSR atlas7 init dts for 3.20
In-Reply-To: <CAGsJ_4wBEmLa8t-bVBQTBhJDHSU=-ciycpAnH4arWPNUq-tHWA@mail.gmail.com>
References: <CAGsJ_4wBEmLa8t-bVBQTBhJDHSU=-ciycpAnH4arWPNUq-tHWA@mail.gmail.com>
Message-ID: <20150113021347.GD28758@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 11, 2015 at 10:51:40PM +0800, Barry Song wrote:
> Hi Arnd, Kevin, Olof,
> 
> The following changes since commit b7392d2247cfe6771f95d256374f1a8e6a6f48d6:
> 
>   Linux 3.19-rc2 (2014-12-28 16:49:37 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> 
> for you to fetch changes up to e57574b88f1d29de0b0e9a3a994cd60c8b800253:
> 
>   ARM: dts: add init dts file for CSR atlas7 SoC (2015-01-11 22:39:10 +0800)
> 
> ----------------------------------------------------------------
> drop marco and add init dts for atlas7
> 
> marco chip has been dropped and the new replacement is atlas7.
> so, drop marco dts, and add dts for atlas7.

Hi,

Can you please elaborate a bit. Was marco never shipped to customers
that could be interested in mainline support, and atlas7 is a replacement
SoC that is in development or has shipped?


Thanks,

-Olof
