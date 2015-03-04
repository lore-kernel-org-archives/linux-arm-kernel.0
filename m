From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 4 Mar 2015 13:55:48 +0100
Subject: [PATCH 1/2] i2c: nomadik: match return type of
 wait_for_completion_timeout
In-Reply-To: <1423398873-24653-1-git-send-email-hofrat@osadl.org>
References: <1423398873-24653-1-git-send-email-hofrat@osadl.org>
Message-ID: <CACRpkdYod8K75CnC7R6i9ghjEp6vuXfi64QUMGt=2sNexviRdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 8, 2015 at 1:34 PM, Nicholas Mc Guire <hofrat@osadl.org> wrote:

> return type of wait_for_completion_timeout is unsigned long not int. as
> timeout is used for wait_for_completion_timeout exclusively here its
> type is simply changed to unsigned long.
>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
