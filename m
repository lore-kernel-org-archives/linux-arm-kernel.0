From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 31 Oct 2017 11:06:56 +0100
Subject: [PATCH] mfd: ab8500-debugfs: Use common error handling code in
 ab8500_print_modem_registers()
In-Reply-To: <7af3098c-21fd-aa16-237f-0359d312cac7@users.sourceforge.net>
References: <7af3098c-21fd-aa16-237f-0359d312cac7@users.sourceforge.net>
Message-ID: <CACRpkdYcxuYyYhXQ86qs--QKY=ovHhdOOYAV=XxSN_7mDONQ1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 27, 2017 at 5:37 PM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 27 Oct 2017 17:20:45 +0200
>
> Add jump targets so that two error messages are stored only once
> at the end of this function implementation.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
