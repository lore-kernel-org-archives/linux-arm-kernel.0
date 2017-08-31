From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 31 Aug 2017 15:51:05 +0200
Subject: [PATCH] pinctrl: uniphier: fix members of rmii group for Pro4
In-Reply-To: <1503886886-30065-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1503886886-30065-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <CACRpkdZ6Db=FivejdqG=WHbwot80Jq9xEeF58F1h9n7EuL94Hg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 28, 2017 at 4:21 AM, Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:

> The ether_rmii_groups should have "ether_rmii" and "ether_rmiib" as
> members. This patch replaces to them.
>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Patch applied with Fixes: tag and ACKs.

Yours,
Linus Walleij
