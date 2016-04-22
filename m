From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 Apr 2016 18:39:11 +0200
Subject: [PATCH v2 1/5] doc: DT: Add Generic Serial Device Tree Bindings
In-Reply-To: <1461338544-29568-2-git-send-email-geert+renesas@glider.be>
References: <1461338544-29568-1-git-send-email-geert+renesas@glider.be>
 <1461338544-29568-2-git-send-email-geert+renesas@glider.be>
Message-ID: <8069345.P8OpMx2dox@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 22 April 2016 17:22:20 Geert Uytterhoeven wrote:
> Document a set of generic properties for describing UARTs in a
> device tree:
>   1. The GPIO modem control properties are currently duplicated across
>      hardware-specific binding documentation,
>   2. The property for dedicated RTS/CTS hardware flow control lines is
>      already supported by several drivers, albeit with a vendor-specific
>      prefix, hence make it generic.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Rob Herring <rob@kernel.org>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
