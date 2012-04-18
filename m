From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 18 Apr 2012 18:12:14 +0200
Subject: [PATCH 04/16] drivers/net: Do not free an IRQ if its request
 failed
In-Reply-To: <1334659448-11521-5-git-send-email-lee.jones@linaro.org>
References: <1334659448-11521-1-git-send-email-lee.jones@linaro.org>
 <1334659448-11521-5-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZr27rhT_c4tLOrjFRJn49F18bM7JAiXT++uw5=m+iMyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2012 at 12:43 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Refrain from attempting to free an interrupt line if the request
> fails and hence, there is no IRQ to free.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
> ?drivers/net/ethernet/smsc/smsc911x.c | ? ?3 +--
> ?1 files changed, 1 insertions(+), 2 deletions(-)

You need to send this to linux-netdev, these are merged in
David Millers tree.

Yours,
Linus Walleij
