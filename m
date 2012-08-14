From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Aug 2012 13:20:32 +0200
Subject: [PATCH 18/22] ARM: ux500: Rename MSP board file to something more
 meaningful
In-Reply-To: <1344527268-5964-19-git-send-email-lee.jones@linaro.org>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
 <1344527268-5964-19-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdaJcfLNzZ4s4NOyBLROjNbNfP8m0EewFkwe6tTrCS-Hog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 9, 2012 at 5:47 PM, Lee Jones <lee.jones@linaro.org> wrote:

> The 'msp' board file does more than just register MSP devices. It
> also registers some other components necessary to get audio working
> on ux500 based platforms; such as the PCM and Machine Drivers. For
> that reason we're changing the filename to be more encompassing -
> 'audio'.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Ideally I want Ola to confirm this but it looks OK to me.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Consider using git format-patch -m which detects renames
and makes for much more compact patches.

Yours,
Linus Walleij
