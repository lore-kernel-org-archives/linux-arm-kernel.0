From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 4 Jun 2013 11:19:39 +0200
Subject: [PATCH] ARM: ux500: Enable HIGHMEM in the u8540 defconfig
In-Reply-To: <1370012946-7374-1-git-send-email-lee.jones@linaro.org>
References: <1370012946-7374-1-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZ4EwEgH596VPVvzWYhi054237mZruhEsdZYdwvdPvRyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 31, 2013 at 5:09 PM, Lee Jones <lee.jones@linaro.org> wrote:

> In order to utilise all of the memory located on ux500 based devices
> we have to enable HIGHMEM. Without it the kernel truncates memory down
> to what's left after the PAGE_OFFSET has been applied, which doesn't
> leave an awful lot, especially if we're running large rootfs' such
> as full Linux desktop distributions or Android.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Patch applied, but I renamed the topic arch to u8500
as the defconfig is named as such.

Yours,
Linus Walleij
