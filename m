From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 17 May 2013 08:31:31 +0200
Subject: u8500_defconfig: build failure in linux-next
In-Reply-To: <CAGa+x85Q8i9DCdTprbVX1opB9UdeD4uxAQpZ-CsqPYt86dLVFA@mail.gmail.com>
References: <CAGa+x85Q8i9DCdTprbVX1opB9UdeD4uxAQpZ-CsqPYt86dLVFA@mail.gmail.com>
Message-ID: <CACRpkdYLskC67vXQsVq470yo5J+E6eLtPz5-em4Qd_Pe0pwJiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 16, 2013 at 1:29 AM, Kevin Hilman <khilman@linaro.org> wrote:

> Lee, Linus,
>
> In building all the ARM defconfigs in linux-next, I noticed
> u8500_defconfig not building:
>
>   [...]
>   CC      drivers/mfd/ab8500-debugfs.o
> /work/kernel/next/drivers/mfd/ab8500-debugfs.c:95:23: fatal error:
> mach/irqs.h: No such file or directory
>
> Same build error on v3.10-rc1 and Linus' master branch (but is fine on v3.9)

Yes, I sent this patch:
http://marc.info/?l=linux-kernel&m=136601206705342&w=2

Sam's been a bit overloaded that is why it's taking time to reach
Torvalds tree. Recently Lee started to help out queueing patches
for MFD so hopefully the bottleneck will be solved this way.

Yours,
Linus Walleij
