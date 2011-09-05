From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 5 Sep 2011 14:35:43 +0200
Subject: [PATCH] mach-integrator: fix VGA base regression
In-Reply-To: <1315172408-18957-1-git-send-email-linus.walleij@linaro.org>
References: <1315172408-18957-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CACRpkdZfCd6XfV12v9_pJ+zpW7JNSLVm6pZNn6VhFMiB7SNJsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 4, 2011 at 11:40 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

> The changes introduced in commit
> cc22b4c18540e5e8bf55c7d124044f9317527d3c
> "ARM: set vga memory base at run-time"

Arnd can you choose whether to apply this patch or revert
the commit making it necessary?

Thanks,
Linus Walleij
