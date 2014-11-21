From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 21 Nov 2014 16:41:56 +0800
Subject: [GIT PULL] ARM: imx: device tree changes for 3.19
In-Reply-To: <201411201733.10706.arnd@arndb.de>
References: <20141119070752.GG27759@dragon> <201411201733.10706.arnd@arndb.de>
Message-ID: <CAAQ0ZWR4KnW-NfqLLr5QMUgPqLOt2FUmwUnr9NSyoGGUfS1QMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 21, 2014 at 12:33 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> Again, all changes here look good to me, but as it's based on top of hte
> other branch, please rebase again. Can you also explain in the tag
> description why you have based on the other branch? I assume you had
> a good reason, but it's not obvious to me.

The patch "ARM: dts: imx53: add cpufreq-dt support" on imx/dt branch
uses the clock define IMX5_CLK_ARM that is added by "ARM: imx53: clk:
add ARM clock" sitting on imx/soc branch.  I will put a note into the
tag description regarding this dependency.

Shawn
