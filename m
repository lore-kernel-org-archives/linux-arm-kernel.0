From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 13 Dec 2013 10:28:55 +0100
Subject: [PATCH 2/3] ARM: ux500: Configure regulator for I/O voltage for
 SD-card slot
In-Reply-To: <1386855098-14272-3-git-send-email-ulf.hansson@linaro.org>
References: <1386855098-14272-1-git-send-email-ulf.hansson@linaro.org>
 <1386855098-14272-3-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CACRpkdYv=bsCoWU2BNg=0UA6B4T2Jt9tenBxLC8===6wXrpnKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 2:31 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> To be able to enable SDR12|25 for SD-cards, we needed to fixup the
> configuration in DT of the gpio regulator, which handles the signal
> voltage level. Some configuration were missing and some were wrong.
>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Patch applied to the ux500-devicetree branch, thanks!

Yours,
Linus Walleij
