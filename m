From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 8 Jun 2016 14:12:27 +0200
Subject: [PATCH 8/8] dmaengine: Remove site specific OOM error messages on
 kzalloc
In-Reply-To: <1465321121-22238-9-git-send-email-peter.griffin@linaro.org>
References: <1465321121-22238-1-git-send-email-peter.griffin@linaro.org>
 <1465321121-22238-9-git-send-email-peter.griffin@linaro.org>
Message-ID: <CACRpkdaf1d8CvBmFCT+bWiXR9ddJ0Mpu5hMi2fzR6sLCXt3EqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 7, 2016 at 7:38 PM, Peter Griffin <peter.griffin@linaro.org> wrote:

> If kzalloc() fails it will issue it's own error message including
> a dump_stack(). So remove the site specific error messages.
>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

A few subsystems may use a cleanup like this...
I wonder how many unnecessary prints I've introduced
myself :P

Yours,
Linus Walleij
