From: olof@lixom.net (Olof Johansson)
Date: Tue, 18 Jun 2013 10:03:52 -0700
Subject: linux-next: origen build failed at
 drivers/pinctrl/pinctrl-exynos.c
In-Reply-To: <CA+G9fYu3_-RZxFyRENuqJvzsM=YToT7PG+5fUytMzhsFu3=z7g@mail.gmail.com>
References: <CA+G9fYu3_-RZxFyRENuqJvzsM=YToT7PG+5fUytMzhsFu3=z7g@mail.gmail.com>
Message-ID: <CAOesGMhL7P350yPkxEKAZ+FS9X6QMFL+4gv5dCRBCW8rwQBB0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


On Tue, Jun 18, 2013 at 9:19 AM, Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
> Hi,
>
> linux-next branch failed to build origen build
>
> defconfig: exynos_defconfig

This was broken yesterday and fixed today. Getting linux-next build
error reports that are 24+ hours old isn't very useful, unfortunately.

It'd also be convenient if you supplied the "git describe" version
number of the source tree in these reports, so it'd be trivial to find
out by glancing at the report, instead of going to the build log.

(Besides that, thanks for the bug report!)


-Olof
