From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 28 Oct 2014 16:41:27 +0100
Subject: [PATCH 4/4] pinctrl: berlin: use the generic node to map function
In-Reply-To: <1413792260-4265-5-git-send-email-antoine.tenart@free-electrons.com>
References: <1413792260-4265-1-git-send-email-antoine.tenart@free-electrons.com>
 <1413792260-4265-5-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <CACRpkdYQbz8ZSe-Rt8DfpNnJNbJYONcmxx6M3c5MrYvvNOygOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 20, 2014 at 10:04 AM, Antoine Tenart
<antoine.tenart@free-electrons.com> wrote:

> A generic node to map function has been added into the pinctrl
> framework. It is provieded by GENERIC_PINCONF. Use it in the Berlin
> pinctrl driver as it fits the needs.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>

Really nice. Will just apply this with the other stuff in the revised version.

Yours,
Linus Walleij
