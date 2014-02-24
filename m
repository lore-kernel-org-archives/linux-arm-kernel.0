From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 24 Feb 2014 15:42:45 +0100
Subject: [PATCH v3 5/7] ARM: at91: gpio: implement get_direction
In-Reply-To: <1392656247-3351-6-git-send-email-richard.genoud@gmail.com>
References: <1392656247-3351-1-git-send-email-richard.genoud@gmail.com>
 <1392656247-3351-6-git-send-email-richard.genoud@gmail.com>
Message-ID: <CACRpkdZCvTM8aD2-pJQSeX7rm01F5tgBGisJvK+uBr4NP7jd+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 17, 2014 at 5:57 PM, Richard Genoud
<richard.genoud@gmail.com> wrote:

> This is needed for gpiod_get_direction().
> Otherwise, it returns -EINVAL.
>
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Nicolas: please apply this through the AT91 tree.

Yours,
Linus Walleij
