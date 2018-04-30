From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 30 Apr 2018 09:13:52 +0200
Subject: [PATCH v2] ARM: defconfig: Update Gemini defconfig
In-Reply-To: <CAK8P3a1X_hKLo3o1YmkxayncUGbTuTR+HKftmvbCtwQegO7zHw@mail.gmail.com>
References: <20180420090044.17036-1-linus.walleij@linaro.org>
 <CAK8P3a1X_hKLo3o1YmkxayncUGbTuTR+HKftmvbCtwQegO7zHw@mail.gmail.com>
Message-ID: <CACRpkdZM1sTC47htB4dP_PgLuzd57C2n==6g=8H_UgzuMrWzfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2018 at 4:57 PM, Arnd Bergmann <arnd@arndb.de> wrote:

>> ARM SoC folks: please apply this for fixes.
>
> I've applied it to the fixes branch now, but I don't see why I didn't
> get the patch before the merge window when you already
> had a version for the v4.16 window.

It's because of my ways of working: I work on a target and then right after
the merge window at -rc1 I usually check what new drivers I managed
to get upstream and then for those that made it I send a patch enabling
them in in the defconfig in the target system.

After sending the defconfig patch for v4.16-rc1 I simply forgot about
it until the next -rc1...

Yours,
Linus Walleij
