From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 27 Mar 2018 17:11:11 -0700
Subject: [GIT PULL] Amlogic 64-bit DT updates for v4.17
In-Reply-To: <CAK8P3a1kJu+XrNfzYvarP6c2VLX4fWwkZV6Sq_u8qqpeprpk9w@mail.gmail.com>
 (Arnd Bergmann's message of "Tue, 27 Mar 2018 14:23:24 +0200")
References: <7hd0zzr4jp.fsf@baylibre.com>
 <CAK8P3a1kJu+XrNfzYvarP6c2VLX4fWwkZV6Sq_u8qqpeprpk9w@mail.gmail.com>
Message-ID: <7ho9j9oy8w.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Tue, Mar 20, 2018 at 1:09 AM, Kevin Hilman <khilman@baylibre.com> wrote:
>> Neil Armstrong (4):
>>       ARM64: dts: amlogic: Convert to new-style SPDX license identifiers
>>       ARM64: dts: meson-gxbb-wetek: add a wetek specific dtsi to cleanup hub and play2
>>       meson-gx-socinfo: Add package id for S905H
>
> That last commit seems misplaced in this branch, but I've pulled it anyway,
> since it's only a oneline change.
>
> Any idea what happened? If it was intentional, I would have expected an
> explanation in the tag description.

It was a mistake, it should've been in the drivers pull.

Thanks for taking it anyways,

Kevin
