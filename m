From: robh@kernel.org (Rob Herring)
Date: Tue, 25 Sep 2018 04:24:34 -0700
Subject: [PATCH 1/3] serial: 8250_uniphier: remove unused "fifo-size"
 property
In-Reply-To: <1537334893-26079-2-git-send-email-yamada.masahiro@socionext.com>
References: <1537334893-26079-1-git-send-email-yamada.masahiro@socionext.com>
 <1537334893-26079-2-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <5baa1af3.1c69fb81.4e5cb.3bca@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 19 Sep 2018 14:28:11 +0900, Masahiro Yamada wrote:
> The FIFO size of the UART devices is 64 on almost all UniPhier SoCs
> with the exception Pro4TV SoC (MN2WS0230), which used 128 FIFO size.
> However, Pro4TV SoC was never upstreamed, and out of production.
> 
> So, this property has never been used in a useful way.
> Let's remove old unused code.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  Documentation/devicetree/bindings/serial/uniphier-uart.txt |  4 ----
>  drivers/tty/serial/8250/8250_uniphier.c                    | 10 +---------
>  2 files changed, 1 insertion(+), 13 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
