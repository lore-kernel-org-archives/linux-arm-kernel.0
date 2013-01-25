From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 25 Jan 2013 10:54:17 +0100
Subject: [PATCH 02/10] gpio: pxa: identify ed mask reg with platform data
In-Reply-To: <1358929554-32265-3-git-send-email-haojian.zhuang@linaro.org>
References: <1358929554-32265-1-git-send-email-haojian.zhuang@linaro.org>
 <1358929554-32265-3-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CACRpkdYnMhWYy_FGrJs+=DN7od08nk5eeansPNaq9nxhm61-=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 23, 2013 at 9:25 AM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:

> Avoid to judge whether edge mask register exists by CPU. Use platform
> data to identify it instead. The gpio edge mask register exists in MMP
> series SoC.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

ARM SoC folks: do you approve (ACK) this patch so I
can apply it to my GPIO tree?

It looks allright to me, I just want to know so that there are no
huge changes around this code in the ARM SoC tree that will
cause trouble.

Yours,
Linus Walleij
