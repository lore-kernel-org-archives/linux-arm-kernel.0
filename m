From: robh@kernel.org (Rob Herring)
Date: Tue, 25 Sep 2018 04:24:35 -0700
Subject: [PATCH 3/3] serial: 8250_uniphier: add auto-flow-control support
In-Reply-To: <1537334893-26079-4-git-send-email-yamada.masahiro@socionext.com>
References: <1537334893-26079-1-git-send-email-yamada.masahiro@socionext.com>
 <1537334893-26079-4-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <5baa1af4.1c69fb81.52980.4bc3@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 19 Sep 2018 14:28:13 +0900, Masahiro Yamada wrote:
> From: Dai Okamura <okamura.dai@socionext.com>
> 
> Add selective auto-flow-control support for UniPhier serial driver.
> 
> Signed-off-by: Dai Okamura <okamura.dai@socionext.com>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  Documentation/devicetree/bindings/serial/uniphier-uart.txt | 3 +++
>  drivers/tty/serial/8250/8250_uniphier.c                    | 3 +++
>  2 files changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
