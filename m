From: robh@kernel.org (Rob Herring)
Date: Sat, 19 Mar 2016 19:18:28 -0500
Subject: [RESEND PATCH] ARM: at91/dt: sama5d2: add SFR node
In-Reply-To: <1458230640-26049-1-git-send-email-ludovic.desroches@atmel.com>
References: <1458230640-26049-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20160320001828.GA27678@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 17, 2016 at 05:04:00PM +0100, Ludovic Desroches wrote:
> From: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> 
> This SFR node is looked up by the I2S controller driver to tune the
> SFR_I2SCLKSEL register.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
>  Documentation/devicetree/bindings/arm/atmel-at91.txt |  2 +-
>  arch/arm/boot/dts/sama5d2.dtsi                       |  5 +++++
>  include/soc/at91/atmel-sfr.h                         | 18 ++++++++++++++++++
>  3 files changed, 24 insertions(+), 1 deletion(-)
>  create mode 100644 include/soc/at91/atmel-sfr.h

Acked-by: Rob Herring <robh@kernel.org>
