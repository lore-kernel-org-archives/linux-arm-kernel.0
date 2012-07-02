From: olof@lixom.net (Olof Johansson)
Date: Mon, 2 Jul 2012 09:25:42 -0700
Subject: [GIT PULL]
In-Reply-To: <4FF06F7C.8050701@antcom.de>
References: <4FDF9419.2090601@antcom.de>
 <CAOesGMhbRnU3wExk88Wkc2=YwbuNpt_uPEsAfmZh6_os9CkqiA@mail.gmail.com>
 <4FF06F7C.8050701@antcom.de>
Message-ID: <CAOesGMjBwQJePVc_V5ZHiz6NdOXTXauqBFEpN7UePgg6_DfztA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Jul 1, 2012 at 8:40 AM, Roland Stigge <stigge@antcom.de> wrote:

> Building upon the branch you just pulled, I'll separate out the further
> patches into topic branches. Is there a certain set of those which I
> should use to adjust to arm-soc structure? E.g.:
>
> lpc32xx/core
> lpc32xx/defconfig
> lpc32xx/dts
>
> ?
>
> Thanks for pointing this out!

Yep, that looks good.

In general, we've had the following categories in arm-soc:

* non-critical-fixes
* cleanup
* dts updates
* SoC support updates
* SoC driver updates
* power-management related changes
* clock related changes
* pinctrl related changes
+ other topics depending on what's going on that merge window
(defconfig, maintainers, etc).


Thanks!

-Olof
