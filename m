From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Dec 2017 17:21:44 +0100
Subject: [GIT PULL 3/3] dts changes for omaps for v4.16 merge window
In-Reply-To: <pull-1513266986-900907@atomide.com-3>
References: <pull-1513266986-900907@atomide.com>
 <pull-1513266986-900907@atomide.com-3>
Message-ID: <CAK8P3a1tYb_asjD3sTZok5g_aE0m2BgTVYML8SZb9t=iku4TCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 14, 2017 at 4:58 PM, Tony Lindgren <tony@atomide.com> wrote:
> Dts related changes for omaps for v4.16 merge window
>
> These changes are mostly improvments for various devices.
> Note that these are based on my earlier fixes branch
> omap-for-v4.15/fixes-dt to avoid a pointless merge conflict
> between a fix and removal. The summary of changes is:
>
> - Fix audio codec reset pin for am335x-pepper and n900, this
>   has been always broken and won't get fixed until the related
>   driver changes are also merged in for v4.16, so not urgent
>
> - Fix tps65917 powerhold property for dra76-evm
>
> - Changes to logicpd boards to remove MTD partition information
>   and to add support for omap35xx variants by setting up common
>   dts files for the logicpd boards
>
> - Disable dra7 USB metastability workaround, this won't do
>   anything until the related driver changes are also merged
>   into v4.16, so not urgent

Pulled into next/dt, thanks!

         Arnd
