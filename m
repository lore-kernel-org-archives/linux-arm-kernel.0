From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 29 Apr 2016 16:13:36 +0200
Subject: [RFC v5 1/4] gpio: generic: fix GPIO_GENERIC_PLATFORM is set to
 module case
In-Reply-To: <e365a17a9080ad6d16fe934121d78adb0402d0d5.1461888822.git.chunkeey@googlemail.com>
References: <cover.1461888822.git.chunkeey@googlemail.com>
 <e365a17a9080ad6d16fe934121d78adb0402d0d5.1461888822.git.chunkeey@googlemail.com>
Message-ID: <CACRpkda0By+G-K-SvyaMAfqt-2SLpP0JtmMhoBf3nt-3+YPWtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 29, 2016 at 2:53 AM, Christian Lamparter
<chunkeey@googlemail.com> wrote:

> GPIO_GENERIC_PLATFORM is a tristate. If the module option is
> selected the resulting gpio-generic.ko will lack most of the
> module initialzation and probe code.
>
> Signed-off-by: Christian Lamparter <chunkeey@googlemail.com>

Obviously correct, patch applied.

Yours,
Linus Walleij
