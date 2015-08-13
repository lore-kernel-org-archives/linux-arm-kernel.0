From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 13 Aug 2015 14:29:47 +0200
Subject: [PATCH v2 0/6] ARM: shmobile: Move gpio ranges from C code to DT
In-Reply-To: <20150805005540.GB20726@verge.net.au>
References: <1438696519-13727-1-git-send-email-geert+renesas@glider.be>
 <20150805005540.GB20726@verge.net.au>
Message-ID: <CACRpkdY7P86+SxMr5-HnhrN5fC-N1U135jiGAJGTV=xx47VW5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 5, 2015 at 2:55 AM, Simon Horman <horms@verge.net.au> wrote:

> Where possible I prefer not to apply non-DTS/DTSI patches on top of
> DTS/DTSI patches, I believe this is in keeping with how the ARM SoC
> maintainers like things handled.  With this in mind I have done the following:
>
> 1. Queued up the DTSI patches (patches 1 - 3) for v4.3 in my dt branch.
>    I intend for this to turn up in next soon.
> 2. Queued up for pinctrl patches (patches 4 - 6) for v4.4 in a pinctrl patch.
>    I intend for these to be present in the renesas devel branch but
>    not in next until after the release of v4.3-rc1. I would also be
>    happy to drop them and let Linus Walleij take these patches for v4.4,
>    assuming patches 1 - 3 are accepted for v4.3.

OK.

Will the world explode if I try to queue the pinctrl patches 4-6 in my
tree now for v4.3? Then I prefer to defer to v4.4. Else I can merge
it in parallel?

Yours,
Linus Walleij
