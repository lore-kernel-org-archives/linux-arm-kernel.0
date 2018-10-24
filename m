From: robh@kernel.org (Rob Herring)
Date: Wed, 24 Oct 2018 08:55:44 -0500
Subject: [PATCH v5 03/11] dt-bindings: gpio: gpio-axp209: add AXP803 GPIO
 bindings
In-Reply-To: <20181023185330.10472-4-oskari@lemmela.net>
References: <20181023185330.10472-1-oskari@lemmela.net>
 <20181023185330.10472-4-oskari@lemmela.net>
Message-ID: <20181024135544.GA31518@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Oct 2018 21:53:22 +0300, Oskari Lemmela wrote:
> The AXP803 GPIO is compatible with AXP813 GPIO, but add
> specific compatible for it.
> 
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> ---
>  Documentation/devicetree/bindings/gpio/gpio-axp209.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
