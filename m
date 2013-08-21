From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 22 Aug 2013 00:18:54 +0200
Subject: [PATCH] pinctrl: SPEAr310: Pass correct of_device_id table name
 to MODULE_DEVICE_TABLE
In-Reply-To: <1376978280.19775.1.camel@phoenix>
References: <1376978280.19775.1.camel@phoenix>
Message-ID: <CACRpkdYWLZt_iNAxR7PcmcLMB7ZB2FFpzQQ_k1HzoAEKFsRFwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 20, 2013 at 7:58 AM, Axel Lin <axel.lin@ingics.com> wrote:

> The symbol SPEAr310_pinctrl_of_match does not exist at all. Fix it.
> We didn't hit the compile error because this driver can only be built-in now.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Patch applied with Viresh's ACK.

Yours,
Linus Walleij
