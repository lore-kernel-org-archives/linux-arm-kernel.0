From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 6 Jul 2012 09:23:17 +0200
Subject: [PATCH 8/9] ARM: ux500: Clean-up temporary Device Tree enablement
 helpers
In-Reply-To: <1341493572-29735-9-git-send-email-lee.jones@linaro.org>
References: <1341493572-29735-1-git-send-email-lee.jones@linaro.org>
 <1341493572-29735-9-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkda6Ocmp=zoc1f4bA1XjyucZf+it8X+a06cwYJ3-9LECtg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 5, 2012 at 3:06 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Here we remove some of the extra overhead we introduced to make
> DT:ing the Snowball platform easier. Unfortunately we can't
> remove everything. We are forced to leave cpufreq and DMA behind
> until they have been successfully Device Tree enabled.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

The patch is straight-forward but the commit message is confusing.

This just simplifies the code, the last two sentences about leaving
cpufreq and DMA behind you can put in your weekly report or
something :-)

Yours,
Linus Walleij
