From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 30 Oct 2017 12:12:49 +0100
Subject: [GIT PULL] Amlogic SoC updates for v4.15
In-Reply-To: <CAK8P3a1fLbzp4xzFyTEO1w4vu=X=wwSV74_WBXiuYqTeF1P5ng@mail.gmail.com>
 (Arnd Bergmann's message of "Mon, 30 Oct 2017 11:26:07 +0100")
References: <7hy3ntq50j.fsf@baylibre.com>
 <CAK8P3a1fLbzp4xzFyTEO1w4vu=X=wwSV74_WBXiuYqTeF1P5ng@mail.gmail.com>
Message-ID: <7hy3nsubwu.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ + Martin ]
Arnd Bergmann <arnd@arndb.de> writes:

> On Sun, Oct 29, 2017 at 5:43 PM, Kevin Hilman <khilman@baylibre.com> wrote:
>
>> ----------------------------------------------------------------
>> Amlogic SoC updates for v4.15
>> - add SMP support to Meson8/8b
>
> Pulled into next/soc. For my understanding, could you clarify what
> this line is needed for on meson?
>
> +textofs-$(CONFIG_ARCH_MESON) := 0x00208000

I belive this is due to the first 2M being reserved for secure memory
on some Meson8 SoCs, but maybe Martin can add more clarification if
needed.

Kevin
