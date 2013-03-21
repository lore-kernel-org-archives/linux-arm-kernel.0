From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 21 Mar 2013 12:39:49 +0100
Subject: [PATCHv3 00/14] drivers: mailbox: framework creation
In-Reply-To: <1363145021-14339-1-git-send-email-s-anna@ti.com>
References: <1363145021-14339-1-git-send-email-s-anna@ti.com>
Message-ID: <CACRpkdYpJLdTx_sVyLj+MVzXqcyfucyP8qy_b_8jiArU+NSMfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 13, 2013 at 4:23 AM, Suman Anna <s-anna@ti.com> wrote:

> Please find the updated mailbox patch series for pulling into linux-next.
> The series is rebased on top of 3.9-rc2, and includes one new patch to
> rename an existing mailbox.h added as part of the highbank cpufreq
> support for 3.9 merge window [1].

ARM SoC folks:

would you consider pulling this stuff into the ARM SoC tree?

It turns out that ux500 multiplatform support is sort of relying
on this refactoring since it helps us to break apart the huge
PRCMU driver.

I am proceeding with my multiplatform work but things like
this not being upstream will make the patches look ugly
and I cannot quite consider it properly done before this is
fixed too.

Yours,
Linus Walleij
