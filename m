From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 23 May 2017 11:34:19 +0200
Subject: [PATCH 1/3] gpio: max732x: move header file out of I2C realm
In-Reply-To: <20170521215727.1243-2-wsa@the-dreams.de>
References: <20170521215727.1243-1-wsa@the-dreams.de>
 <20170521215727.1243-2-wsa@the-dreams.de>
Message-ID: <CACRpkdaO3bjg2HfOw7kk-wMd8YdF-13PZOh35PvEnP+wTQ60Wg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 21, 2017 at 11:57 PM, Wolfram Sang <wsa@the-dreams.de> wrote:

> include/linux/i2c is not for client devices. Move the header file to a
> more appropriate location.
>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Patch applied.

Yours,
Linus Walleij
