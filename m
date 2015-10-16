From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 16 Oct 2015 22:20:50 +0200
Subject: [PATCH v6 4/7] arm64: berlin: add the pinctrl dependency for
 Marvell Berlin SoCs
In-Reply-To: <CACRpkdaKBZEN7j3rc9vzT_schNerqKorwckZeKuFEAugbzGBgQ@mail.gmail.com>
References: <1444981032-4401-1-git-send-email-jszhang@marvell.com>
 <1444981032-4401-5-git-send-email-jszhang@marvell.com>
 <CACRpkdaKBZEN7j3rc9vzT_schNerqKorwckZeKuFEAugbzGBgQ@mail.gmail.com>
Message-ID: <56215C22.4080705@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16.10.2015 16:15, Linus Walleij wrote:
> On Fri, Oct 16, 2015 at 9:37 AM, Jisheng Zhang <jszhang@marvell.com> wrote:
>
>> This is to add the pinctrl dependency for Marvell Berlin SoCs.
>>
>> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
>> Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>> Acked-by: Antoine Tenart <antoine.tenart@free-electrons.com>
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> Please push this through the ARM SoC tree or wherever patches
> to this file goes. It doesn't seem to be a hard dependency to the
> pin control patches.

[Added arm-soc Maintainers]

This patch is touching arch/arm64/Kconfig.platforms. The hunk is
very small so that it may be ok that I apply and send it with
the next PR.

If the arm-soc Maintainers want to pick it up, I can resend the
original patch with all Acked-by to arm-soc maintainer e-mail
directly.

Sebastian
