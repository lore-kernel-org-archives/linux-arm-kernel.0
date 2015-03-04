From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 4 Mar 2015 13:56:17 +0100
Subject: [PATCH 2/2] i2c: nomadik: match status to return type of read_i2c
In-Reply-To: <1423398883-24687-1-git-send-email-hofrat@osadl.org>
References: <1423398883-24687-1-git-send-email-hofrat@osadl.org>
Message-ID: <CACRpkdbb0Upaiab4G6oymzQNiS5akzHKO_8gSr7ZVB7tn8nP0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 8, 2015 at 1:34 PM, Nicholas Mc Guire <hofrat@osadl.org> wrote:

> return type of read_i2c() is int not u32. As the assignments to status
> are consistent with int here its type is changed to int.
>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
