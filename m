From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 12 Sep 2016 20:14:39 +0800
Subject: [PATCH v4 2/3] arm64: dts: Add ZTE ZX296718 SoC dts and Makefile
In-Reply-To: <CABymUCMQQ-nqGwGdNafCsBB10PB=4KAtW4Dij2YzVdfLHS4-WA@mail.gmail.com>
References: <1473141861-5033-1-git-send-email-jun.nie@linaro.org>
 <1473141861-5033-3-git-send-email-jun.nie@linaro.org>
 <20160908091103.GA16924@tiger>
 <CABymUCMQQ-nqGwGdNafCsBB10PB=4KAtW4Dij2YzVdfLHS4-WA@mail.gmail.com>
Message-ID: <20160912121439.GA7373@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 12, 2016 at 03:13:58PM +0800, Jun Nie wrote:
> PLL clocks can be configured actually according to register. But I
> prefer to keep them as fixed clocks due to two reasons:
>  1. ZTE do not want to expose too much information of PLL.
>  2. All clients blocks, such as MMC and video codec, assume the
> related input clock's frequency as a derivation from PLL default
> frequency value in block clock control register description.

Okay, just try to understand the reason behind it.  Thanks.

Shawn
