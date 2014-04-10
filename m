From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Apr 2014 18:27:47 +0200
Subject: [PATCHv3 5/5] net: rfkill: gpio: hard-code the gpio names
In-Reply-To: <1396360976-28657-6-git-send-email-heikki.krogerus@linux.intel.com>
References: <1396360976-28657-1-git-send-email-heikki.krogerus@linux.intel.com>
 <1396360976-28657-6-git-send-email-heikki.krogerus@linux.intel.com>
Message-ID: <CACRpkdbuvyEQVFv07Bq3dAeGEZr-MuJKJ5mYqdzicROJLwvHDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 1, 2014 at 4:02 PM, Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:

> There is no need to dynamically generate the names. This
> will fix a static checker warning..
>
> net/rfkill/rfkill-gpio.c:144 rfkill_gpio_probe()
>     warn: variable dereferenced before check 'rfkill->name'
>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Excellent,
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
