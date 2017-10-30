From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 30 Oct 2017 11:26:07 +0100
Subject: [GIT PULL] Amlogic SoC updates for v4.15
In-Reply-To: <7hy3ntq50j.fsf@baylibre.com>
References: <7hy3ntq50j.fsf@baylibre.com>
Message-ID: <CAK8P3a1fLbzp4xzFyTEO1w4vu=X=wwSV74_WBXiuYqTeF1P5ng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 29, 2017 at 5:43 PM, Kevin Hilman <khilman@baylibre.com> wrote:

> ----------------------------------------------------------------
> Amlogic SoC updates for v4.15
> - add SMP support to Meson8/8b

Pulled into next/soc. For my understanding, could you clarify what
this line is needed for on meson?

+textofs-$(CONFIG_ARCH_MESON) := 0x00208000

Thanks,

    Arnd
