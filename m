From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 30 Jun 2015 08:26:45 +0200
Subject: [PATCH v3 2/2] arm64: dts: mt8173: Add I2C device node
In-Reply-To: <1863259.t4daGE7nbQ@ubix>
References: <1434101229-32695-1-git-send-email-eddie.huang@mediatek.com>
 <1434101229-32695-3-git-send-email-eddie.huang@mediatek.com>
 <CAGS+omB1UadXeKZLmMdhSamsPpipQLmoH_PhbUPvszrYTq68fA@mail.gmail.com>
 <1863259.t4daGE7nbQ@ubix>
Message-ID: <CACRpkdY4=SSZQRQY_ydcsv-S8ezrYbzp2rdD4qRuHkF8oowOEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 12, 2015 at 7:13 PM, Matthias Brugger
<matthias.bgg@gmail.com> wrote:

> In the future when all the device drivers are implemented, this gets you a
> really huge dtsi. AFAIK this can cause a somewhat long parsing time of the dtb
> when booting the system.

Boot time claims need to be backed up with ftrace logs or something. One of
the arguments against device tree in the beginning was parse time and then
we made measurements and it proved moot.

However being unable to manage the dts[i] sources is a valid argument for
simplifying and splitting up stuff.

Yours,
Linus Walleij
