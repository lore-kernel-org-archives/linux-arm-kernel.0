From: olof@lixom.net (Olof Johansson)
Date: Thu, 1 Mar 2012 11:59:21 -0800
Subject: [PATCH 1/8] ARM: tegra: export tegra_gpio_{en,dis}able
In-Reply-To: <1330630010-11241-2-git-send-email-alan@signal11.us>
References: <1330630010-11241-1-git-send-email-alan@signal11.us>
 <1330630010-11241-2-git-send-email-alan@signal11.us>
Message-ID: <CAOesGMhom2ybsKKgezPKkrhH9NniZu+FMprQhibHwEX92MNtEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Mar 1, 2012 at 11:26 AM, Alan Ott <alan@signal11.us> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> These two functions are used in drivers that can be
> modules, so they need to be exported.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

With some of the pinmux changes going in this will no longer be
needed, but it is for now so:

Acked-by: Olof Johansson <olof@lixom.net>
