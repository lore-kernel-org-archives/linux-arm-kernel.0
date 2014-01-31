From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 31 Jan 2014 11:17:23 +0100
Subject: [PATCH v2 00/21] pinctrl: mvebu: restructure and remove hardcoded
 addresses from Dove pinctrl
In-Reply-To: <1390869573-27624-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1390674856-4993-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1390869573-27624-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <CACRpkda5HRxpLWWizT_58SJ6Fb=TQpO=Y5yFThpZkUbUYmU8fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 28, 2014 at 1:39 AM, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:

> This patch set is one required step for Dove to hop into mach-mvebu.
> Until now, pinctrl-dove was hardcoding some registers that do not
> directly belong to MPP core registers. This is not compatible with
> what we want for mach-mvebu.

All this stuff is really nice, so if you can get Thomas to add his
review-tag on this stuff and maybe have some Tested-by:s
from other parties, I'd be happy to pull the end result to the
pinctrl tree, or alternatively provide my ACK for you to take this
through ARM SoC.

Yours,
Linus Walleij
