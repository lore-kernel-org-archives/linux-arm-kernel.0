From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 5 Nov 2012 11:38:24 +0100
Subject: [PATCH 0/9] Pinctrl: SPEAr: Fixes for 3.7-rc3
In-Reply-To: <cover.1351329224.git.viresh.kumar@linaro.org>
References: <cover.1351329224.git.viresh.kumar@linaro.org>
Message-ID: <CACRpkdZ+KhTQq+vrtoCVH2Y7fV4aT6JNzo+dL1Dg-GM8usb=Lg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 27, 2012 at 11:17 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> Hi Linus,
>
> This patchset fixes many errors/mistakes in current pinctrl configurations for
> various SPEAr SoCs. Please see if they can be merged in next rc release, if they
> look fine to you.

First sorry for taking so long...

Basically I have a hard time believeing these are regressions.
I have applied patch 1, 2, 3 and 5 to fixes but I want an argument
of why patch 4 and 6-9 are causing regressions in the current
mainline kernel.

I suspect they are fixing regressions in a non-mainline kernel
which is none of our business, but convince me and I'll move
them to the fixes branch ... I have still merged them, but aimed
for v3.8.

Yours,
Linus Walleij
