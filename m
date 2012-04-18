From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 18 Apr 2012 18:35:05 +0200
Subject: [PATCH 13/16] mfd/db8500-prcmu: Add Device Tree support
In-Reply-To: <1334659448-11521-14-git-send-email-lee.jones@linaro.org>
References: <1334659448-11521-1-git-send-email-lee.jones@linaro.org>
 <1334659448-11521-14-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZ54DL00p+ZbG2mepzAFuZNSN0zkWoGe4n5v9NQnjw8qQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2012 at 12:44 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Here we see the db8500-prcmu driver obtain DT support. In its
> current state, all we have to do is offer a matching compatible
> node and the driver will register and initialise correctly.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
> ?drivers/mfd/db8500-prcmu.c | ? ?5 +++++
> ?1 files changed, 5 insertions(+), 0 deletions(-)

Goes through the MFD tree or I need Sam's ACK.

Yours,
Linus Walleij
