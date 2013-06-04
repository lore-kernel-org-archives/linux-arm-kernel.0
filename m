From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 4 Jun 2013 11:05:18 +0200
Subject: [PATCH 5/5] mfd: ab8500-core: Add of_compatible property for
 ab8500-codec
In-Reply-To: <1369920465-13905-6-git-send-email-fabio.baltieri@linaro.org>
References: <1369920465-13905-1-git-send-email-fabio.baltieri@linaro.org>
 <1369920465-13905-6-git-send-email-fabio.baltieri@linaro.org>
Message-ID: <CACRpkdYTt+0AmqV62WWfLLQE24a7=q0Ahdcm9QLRy6wPSG4MdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 30, 2013 at 3:27 PM, Fabio Baltieri
<fabio.baltieri@linaro.org> wrote:

> Add of_compatible string to the ab8500-codec cell to allow the driver to
> grab handlers such as regulators from device-tree when available.
>
> Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I think Lee is queueing ab8500 patches for Sam these days
to smoothen things, so letting him pick this up.

Yours,
Linus Walleij
