From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 29 Aug 2018 14:07:12 +0200
Subject: [PATCH] pinctrl: Convert to using %pOFn instead of
 device_node.name
In-Reply-To: <20180828015252.28511-40-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-40-robh@kernel.org>
Message-ID: <CACRpkdY-ChkLS39vz6rDUdnR7zuxfu=aD7tky__26fjMP+th1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2018 at 3:55 AM Rob Herring <robh@kernel.org> wrote:

> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>

Patch applied along with the thundering hoard of ACKs.

Yours,
Linus Walleij
