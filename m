From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 31 Oct 2014 08:50:47 +0100
Subject: [PATCH 09/15] ARM: sa1100: don't preallocate IRQ space for locomo
In-Reply-To: <1414454528-24240-10-git-send-email-dbaryshkov@gmail.com>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
 <1414454528-24240-10-git-send-email-dbaryshkov@gmail.com>
Message-ID: <CACRpkdZnAtXtdtKbuqj8a_6a=2jS_Jf6yrq=iz-GJV+4RifRhw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 28, 2014 at 1:02 AM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:

> As new locomo driver properly supports SPARSE_IRQ, stop playing with
> NR_IRQS on sa1100 (locomo was the last chip requiring NR_IRQ tricks).
>
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

That's right! By moving to irqdomain things get even better :)

Yours,
Linus Walleij
