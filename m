From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Apr 2014 18:26:35 +0200
Subject: [PATCHv3 2/5] net: rfkill: gpio: remove unused and obsolete
 platform parameters
In-Reply-To: <1396360976-28657-3-git-send-email-heikki.krogerus@linux.intel.com>
References: <1396360976-28657-1-git-send-email-heikki.krogerus@linux.intel.com>
 <1396360976-28657-3-git-send-email-heikki.krogerus@linux.intel.com>
Message-ID: <CACRpkdatPrWKLNWV7mxxDMaW3xCEgSWqsBN-153c6CmGQz-ifg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 1, 2014 at 4:02 PM, Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:

> After upgrading to descriptor based gpios, the gpio numbers
> are not used anymore. The power_clk_name and the platform
> specific setup and close hooks are not used by anybody, and
> we should not encourage use of such things, so removing them.
>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
