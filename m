From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 30 Oct 2017 17:55:54 +0100
Subject: [GIT PULL] Amlogic 64-bit DT updates for v4.15
In-Reply-To: <CAK8P3a0cO19miC8VU6mZ_L2FLpvfCpYPpseHViUJkSB-O1hWqw@mail.gmail.com>
 (Arnd Bergmann's message of "Mon, 30 Oct 2017 14:36:36 +0100")
References: <7hefpvqxbe.fsf@baylibre.com>
 <CAK8P3a0cO19miC8VU6mZ_L2FLpvfCpYPpseHViUJkSB-O1hWqw@mail.gmail.com>
Message-ID: <7hshe0tw11.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Sun, Oct 22, 2017 at 12:41 PM, Kevin Hilman <khilman@baylibre.com> wrote:
>> Amlogic 64-bit platforms: DT updates for v4.15
>> - new SoC support: A113D
>> - new boards: Tronsmart Vega S96, Khadas vim2
>> - reserved memory fixups
>> - gpio-names cleanups
>> - MMC cleanups, enable high-speed modes
>> - misc cleanups
>
> I've had to 's/secmon at 05000000/secmon at 5000000/g' to avoid re-introducing
> warnings that Rob had previously fixed, otherwise looks good, so I
> pulled it into
> next/dt with that fixup as an 'evil merge'. Thanks,

Oops, sorry to miss that one and thanks for the fixup.

Kevin
