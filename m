From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 1 Mar 2013 13:57:23 +0100
Subject: [PATCH v9 06/10] pinctrl: single: create new gpio function range
In-Reply-To: <1361101376-3783-7-git-send-email-haojian.zhuang@linaro.org>
References: <1361101376-3783-1-git-send-email-haojian.zhuang@linaro.org>
 <1361101376-3783-7-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CACRpkdamqqb65Sij9n=BSYf7HEa8POnaJ0VKJZqRAkKViMHbLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 17, 2013 at 12:42 PM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:

> Since gpio driver could create gpio range in DTS, it could invoke
> pinctrl_request_gpio(). In the pinctrl-single driver, it needs to
> configure pins with gpio function mode.

Applied to the pinctrl tree for v3.10.

Thanks,
Linus Walleij
