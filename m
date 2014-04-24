From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 24 Apr 2014 15:25:29 +0200
Subject: [PATCH 1/4] dma: ste_dma40: Maintain spinlock order while
 handling pause
In-Reply-To: <1398282724-2607-1-git-send-email-ulf.hansson@linaro.org>
References: <1398282724-2607-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CACRpkdbq_fENYN=OiTFVhnh8P46eVf0=9TZ+9Fy=WHNCOZfjhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 23, 2014 at 9:52 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> The runtime PM resume callback needs to be executed while holding the
> spinlock, make sure to maintain this for the pause operation as well.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
