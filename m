From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 29 Apr 2016 16:14:57 +0200
Subject: [RFC v4 2/8] gpio: rename gpio-generic.c into gpio-mmio.c
In-Reply-To: <5d6d06726e8ed05aea6cae0aaa9166b10c408dd0.1461806071.git.chunkeey@googlemail.com>
References: <cover.1461806071.git.chunkeey@googlemail.com>
 <5d6d06726e8ed05aea6cae0aaa9166b10c408dd0.1461806071.git.chunkeey@googlemail.com>
Message-ID: <CACRpkdbZjFz7hmLqzMfhunrj8UHtRremfMTNOQULno83_qWZSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 28, 2016 at 11:05 AM, Christian Lamparter
<chunkeey@googlemail.com> wrote:

> This patch renames the gpio-generic.c into gpio-mmio.c.
> This is because currently the file only contains code
> for a memory-mapped GPIO driver. There isn't any support
> for ioports or other resource type.
>
> Signed-off-by: Christian Lamparter <chunkeey@googlemail.com>

Makes perfect sense.

Patch applied.

Yours,
Linus Walleij
