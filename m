From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 20 May 2012 23:14:21 +0200
Subject: [PATCH 11/18] regulator: Enable the ab8500 for Device Tree
In-Reply-To: <1337262323-27692-12-git-send-email-lee.jones@linaro.org>
References: <1337262323-27692-1-git-send-email-lee.jones@linaro.org>
 <1337262323-27692-12-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdY3N88=KeNa2O7fj2Un8dqd5KngyMzF9ZN6R035NxQ0XA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2012 at 3:45 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Here we setup the ab8500 regulator driver for DT. We first do
> this in the normal way, by providing a match structure during
> initialisation, but then we provide information so that
> whilst probing we can use existing data structures to do DT
> look-ups.
>
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

& thanks to Mark for merging.

Thanks!
Linus Walleij
