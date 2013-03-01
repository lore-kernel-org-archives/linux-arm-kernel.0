From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 1 Mar 2013 01:33:09 +0100
Subject: [PATCH v4 04/11] gpio: pxa: remove gpio_type
In-Reply-To: <1361290948-16669-5-git-send-email-haojian.zhuang@linaro.org>
References: <1361290948-16669-1-git-send-email-haojian.zhuang@linaro.org>
 <1361290948-16669-5-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CACRpkdZZ8V9RDTd6zzhM67A=ZRBt_1MCPfJNismqxBAVDPyW3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 19, 2013 at 5:22 PM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:

> Since gpio_type is used to check whether gafr register is valid. So
> move it into platform data.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

Hm didn't I already ACK this? (hint, changelog maybe?)

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
