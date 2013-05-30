From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 30 May 2013 10:45:51 +0200
Subject: [PATCH 28/39] ARM: ux500: Remove empty function
 u8500_of_init_devices()
In-Reply-To: <1368611522-9984-29-git-send-email-lee.jones@linaro.org>
References: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
 <1368611522-9984-29-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZLjRv3RZk_+gpOJb-4UQcThxPshKeH1Cw-n96FY3250w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 11:51 AM, Lee Jones <lee.jones@linaro.org> wrote:

> As promised, now all devices which resided in u8500_of_init_devices()
> have been enabled for Device Tree, we can completely remove it.
>
> Acked-by: Fabio Baltieri <fabio.baltieri@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied on my ux500-dma40 branch.

And this is looking real good now!

Thanks!
Linus Walleij
