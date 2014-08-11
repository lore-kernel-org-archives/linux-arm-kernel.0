From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 11 Aug 2014 09:49:03 +0200
Subject: [PATCH 09/15] pinctrl: pinctrl-at91.c: fix decimal printf format
 specifiers prefixed with 0x
In-Reply-To: <1407300196-32708-1-git-send-email-hans@hanshq.net>
References: <1407300196-32708-1-git-send-email-hans@hanshq.net>
Message-ID: <CACRpkdbss=0_HJe1V5ABZ6MkKnNgKGNb-xkMbyynn7SuPqap6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 6, 2014 at 6:43 AM, Hans Wennborg <hans@hanshq.net> wrote:

> The prefix suggests the number should be printed in hex, so use
> the %x specifier to do that.
>
> Found by using regex suggested by Joe Perches.
>
> Signed-off-by: Hans Wennborg <hans@hanshq.net>

Patch applied with Alexandre's ACK.

Yours,
Linus Walleij
