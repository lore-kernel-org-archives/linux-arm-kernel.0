From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Apr 2013 10:45:47 +0200
Subject: [PATCH 11/32] ARM: ux500: Remove unused 'data_width' attributes
 from UART DMA configs
In-Reply-To: <1366279934-30761-12-git-send-email-lee.jones@linaro.org>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-12-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZLEn9sui9H8CzrdO9YcxhsqBeU_6aqkWsPaR-=h9014A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 12:11 PM, Lee Jones <lee.jones@linaro.org> wrote:

> DMA configuration data is now allocated in the UART driver, so these
> are just ignored.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
