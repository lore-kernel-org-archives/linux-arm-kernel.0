From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 18 Mar 2017 17:32:43 +0100
Subject: [PATCH 4/4] RFT: irqchip: replace moxa with ftintc010
In-Reply-To: <CACmBeS0BAUPgP7N1FMYvWK583kAOU2ogZ0PqE2hQA2sE5nBpUg@mail.gmail.com>
References: <20170311231505.16056-1-linus.walleij@linaro.org>
 <CACmBeS2rNKnJKsFXeqwuCO5YBgfO8Nv=Wr+cG8DS-gfpfsxENg@mail.gmail.com>
 <CACRpkdYExzp0zRdnYad6XG+58saeCUNNN04-n+hPR-X=1gezOQ@mail.gmail.com>
 <CACmBeS0BAUPgP7N1FMYvWK583kAOU2ogZ0PqE2hQA2sE5nBpUg@mail.gmail.com>
Message-ID: <CACRpkdbKaxroN9-jDYgEvu-nxgtPALOGwJpt8rt0X49bD+gZiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 14, 2017 at 3:58 PM, Jonas Jensen <jonas.jensen@gmail.com> wrote:

> Thanks! everything appear to work right with that patch (see log [1]),
> however, DTC can no longer compile the dtb so the following is a patch
> for that:

Thanks! I folded this into the patch and added your Tested-by.

I will send this separately to the ARM SoC maintainers so they
can prepare the ground by correcting the device tree.

Yours,
Linus Walleij
