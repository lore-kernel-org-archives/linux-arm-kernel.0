From: woogyom.kim@gmail.com (Milo Kim)
Date: Wed, 23 Nov 2016 22:06:18 +0900
Subject: [PATCH] dt-bindings: mfd: Improve readability for TPS65217
 interrupt sources
In-Reply-To: <33562327.jVWx4tN2gP@wuerfel>
References: <20161121131515.8040-1-woogyom.kim@gmail.com>
 <20161122155759.GG10134@dell.home>
 <bd4944d8-3cef-b3f7-4fba-6de590493047@gmail.com>
 <33562327.jVWx4tN2gP@wuerfel>
Message-ID: <27c48fc3-29bd-996b-bdc4-75884a39865a@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/23/2016 08:51 PM, Arnd Bergmann wrote:
> Ah, the numbers come from the data sheet. Please just remove the
> header then, there is no need to keep them as an ABI, in particular
> when the driver doesn't even include that header today.

Got it.

> What matters here is the binding documentation in
> Documentation/devicetree/bindings/power/supply/tps65217_charger.txt

OK, in addition to this, the interrupt specifier needs to be added in 
Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt.

> Please fix that instead to mandate that the two interrupts are
> required, what their functions are, and what the interrupt-names
> (not interrupts-names) property must list.

Oops, wrong interrupt name property - my bad.

Thanks for all your feedback.

Best regards,
Milo
