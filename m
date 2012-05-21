From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 21 May 2012 23:36:02 +0200
Subject: [PATCH 04/16] ARM: ux500: Only initialise STE's UIBs on boards
 which support them
In-Reply-To: <1337330355-17747-5-git-send-email-lee.jones@linaro.org>
References: <1337330355-17747-1-git-send-email-lee.jones@linaro.org>
 <1337330355-17747-5-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdatpXKzzVpHLFrF+26RJoRYzrS3tZb2gg_aUdM_tzzg4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 18, 2012 at 10:39 AM, Lee Jones <lee.jones@linaro.org> wrote:

> ST-Ericsson uses User Interface Boards to extend functionality of
> some of their development boards. However, these aren't compatible
> with all the supported boards found in Mainline (Snowball for
> instance). This patch ensures that the UIBs are only probed on
> boards which can actually support them. This in turn saves lots of
> unnecessary error messages normally found in Snowball's boot log.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Shall I take this through the ux500  tree?

Thanks,
Linus Walleij
