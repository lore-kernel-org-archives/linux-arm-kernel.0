From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 27 Mar 2018 15:32:34 +0200
Subject: [PATCH] arm64: defconfig: add CONFIG_UNIPHIER_THERMAL and
 CONFIG_SNI_AVE
In-Reply-To: <1522153407-21430-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1522153407-21430-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <CAK8P3a3xteNLdGNW=a+jLWmxcEBhBFV8dhL+o0F1AGie=-3hng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 27, 2018 at 2:23 PM, Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:
> Enable the thermal monitor driver and the AVE ethernet driver
> implemented on UniPhier SoCs.
>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Any reason why this is a built-in driver rather than a loadable module?

We have a mix of both today for ethernet drivers, but generally I
would count them as non-essential.

     Arnd
