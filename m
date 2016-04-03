From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sun, 3 Apr 2016 12:09:48 +0200
Subject: [GIT PULL v2] ARM support for generic memremap()
In-Reply-To: <1459514934-28128-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1459514934-28128-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <CAKv+Gu_=yYRzir5MjUN0fF8qxW7vmxQpRgfKPA4WYKU8nMKEKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 April 2016 at 14:48, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> Hello Russell,
>
> This pull request covers the updated v4 of this series that I sent out
> yesterday, which fixed a thinko in my changes to the memremap() fallback
> logic when attempting to reuse the existing kernel direct address of a
> memory range. Anyway, all the required acks are in place for the patches
> that touches drivers/mtd and kernel/, so please pull.
>

Sigh. Please disregard. I appear to have broken !MMU, but I have only
been notified now (after v4) by the kbuild test robot.

I will need to respin this again. v5 coming up

Thanks,
Ard.
