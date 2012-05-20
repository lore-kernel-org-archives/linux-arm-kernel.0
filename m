From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 20 May 2012 23:02:11 +0200
Subject: [PATCH 15/18] mfd: Prevent unassigned pointer from being used in
 ab8500-gpadc driver
In-Reply-To: <1337262323-27692-16-git-send-email-lee.jones@linaro.org>
References: <1337262323-27692-1-git-send-email-lee.jones@linaro.org>
 <1337262323-27692-16-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbOGgRn--hb1v9pvbFx2361b+P+M=M0OeOHhh9=e5SirQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2012 at 3:45 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Before this patch if probe failed to find the platform IRQ it
> would attempt to print a message out using dev_err, which in
> turn was being passed an unassigned pointer. This patch
> ensures the information passed to dev_err is correct.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
