From: dianders@chromium.org (Doug Anderson)
Date: Thu, 27 Aug 2015 08:16:19 -0700
Subject: [PATCH v1 0/5] Fix broken DMAFLUSHP on Rockchips platform
In-Reply-To: <1440685419-22037-1-git-send-email-shawn.lin@rock-chips.com>
References: <1440685419-22037-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <CAD=FV=XTG8RukPwDvVuEifNz9WGUUs3w1B26cpm8obSdV5bFTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn,

On Thu, Aug 27, 2015 at 7:23 AM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> Changes in v1:
> - rename broken-no-flushp to "arm,pl330-broken-no-flushp" suggested
>   by Krzysztof.
> - add From original author.
> - remove Sunny's tag
>
> Shawn Lin (5):
>   DMA: pl330: support burst mode for dev-to-mem and mem-to-dev transmit
>   DMA: pl330: add quirk for broken no flushp
>   ARM: dts: Add arm,pl330-broken-no-flushp quirk for rk3288 platform
>   ARM: dts: Add arm,pl330-broken-no-flushp quirk for rk3xxx platform
>   Documentation: arm-pl330: add description of
>     arm,pl330-broken-no-flushp

Something still seems strange here.  All patches are listed in the
cover letter as "From" you.  You should make sure you change the
author in your git tree using "git commit --amend --author=<author>"
so that patman can generate the proper cover letter.

-Doug
