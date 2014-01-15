From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 15 Jan 2014 09:08:44 +0100
Subject: [PATCH 1/2] pinctrl: sirf: use only one irq_domain for the whole
 device node
In-Reply-To: <1389430123-8036-1-git-send-email-21cnbao@gmail.com>
References: <1389430123-8036-1-git-send-email-21cnbao@gmail.com>
Message-ID: <CACRpkdaTjEH6LpkTOf_Ni5DrvFQAbAZR_fP5C6LRqnvTEv=UKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 11, 2014 at 9:48 AM, Barry Song <21cnbao@gmail.com> wrote:

> From: Barry Song <Baohua.Song@csr.com>
(...)
> this patch drops redundant irq_domain and keep only one to fix the problem.

This is a good cleanup. Patch applied.

Yours,
Linus Walleij
