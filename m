From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 21 May 2012 08:58:25 +0200
Subject: [PATCH 05/16] regulator: db8500-prcmu: Separate regulator
 registration from probe
In-Reply-To: <1337330355-17747-6-git-send-email-lee.jones@linaro.org>
References: <1337330355-17747-1-git-send-email-lee.jones@linaro.org>
 <1337330355-17747-6-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdaw1nCFZ66BCGkVako3rzEKKcXy454Y33L3KsH5NVK7PA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 18, 2012 at 10:39 AM, Lee Jones <lee.jones@linaro.org> wrote:

> This will provide us with a convenient way to register regulators when
> booting with Device Tree both enabled & disabled and will save us a
> great deal of code duplication in time.
>
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
