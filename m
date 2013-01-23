From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 23 Jan 2013 11:01:08 +0100
Subject: [PATCH 1/1] ARM: ux500: Turn on the 'heartbeat' LED trigger
In-Reply-To: <1358775340-8197-1-git-send-email-lee.jones@linaro.org>
References: <1358775340-8197-1-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZY2+5fQ7m8wcbfzJTt-rX7RJPPN5mQ=waPrXV2m7sqDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 21, 2013 at 2:35 PM, Lee Jones <lee.jones@linaro.org> wrote:

> The heartbeat LED trigger provides an excellent debugging tool
> when hacking on development boards. Here we enable it on all
> u8500 based platforms. This will pulse the User LED on the
> Snowball low-cost development board only.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied to my ux500-defconfig branch.

Thanks,
Linus Walleij
