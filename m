From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Aug 2011 09:58:12 +0200
Subject: [PATCH] mach-sa1100: fix PCI build problem
In-Reply-To: <1312539884-10631-1-git-send-email-linus.walleij@linaro.org>
References: <1312539884-10631-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CAKnu2MoBnHDVht0LPR0ip1iZqojh2ab+wx=6mCj-+M2+yOpA3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/8/5 Linus Walleij <linus.walleij@linaro.org>:

> The PCI nanoengine driver in the SA1100 machine probably has not
> been building for some time. It probably dragged hardware.h
> in implicitly and now it doesn't anymore. After this an SA1100
> build selecting all system variants will build successfully.

Arnd can you pick this single patch for the -rc series, or do you
prefer pull requests?

Thanks,
Linus Walleij
