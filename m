From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 7 Aug 2012 14:21:08 +0200
Subject: [PATCH] pinctrl-sirf: remove devm_kfree at error path
In-Reply-To: <1343549498-2217-1-git-send-email-develkernel412222@gmail.com>
References: <1343549498-2217-1-git-send-email-develkernel412222@gmail.com>
Message-ID: <CACRpkdY8zD_14CTGjhXhNMhpb=e5ZJU53xd00=4gQgfZn0WJ=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 29, 2012 at 10:11 AM, Devendra Naga
<develkernel412222@gmail.com> wrote:

> the pointers that are allocated with devm_kzalloc will be automatically freed,
> at unload time.
>
> Signed-off-by: Devendra Naga <develkernel412222@gmail.com>

Applied, Barry if you don't like this, shout now :-)

Yours,
Linus Walleij
