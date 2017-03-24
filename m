From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 Mar 2017 17:51:05 +0100
Subject: [GIT PULL 1/2] Broadcom arm Device Tree fixes for 4.11 (part 2)
In-Reply-To: <20170322180300.27599-1-f.fainelli@gmail.com>
References: <20170322180300.27599-1-f.fainelli@gmail.com>
Message-ID: <CAK8P3a3g_hV6vDxzyBahqhTkg92_D7Js22Z=aMvEeN84SMNakQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 22, 2017 at 7:02 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> The following changes since commit 0c2bf9f95983fe30aa2f6463cb761cd42c2d521a:
>
>   ARM: dts: BCM5301X: Correct GIC_PPI interrupt flags (2017-03-05 17:10:55 -0800)
>
> are available in the git repository at:
>
>   http://github.com/Broadcom/stblinux tags/arm-soc/for-4.11/devicetree-fixes-2
>
> for you to fetch changes up to acfa28b3649ec07775efaac0c00de2db39d71634:
>
>   ARM: dts: NSP: GPIO reboot open-source (2017-03-16 14:04:25 -0700)
>
> ----------------------------------------------------------------
> This pull request contains Broadcom ARM-based SoCs Device Tree fixes for 4.11,
> please pull the following:
>
> - Jon fixes a reboot issue on most Northstar Plus platforms by adding the
>   "open-source" property to the "gpio-restart" Device Tree nodes

Pulled into fixes, thanks!

       Arnd
