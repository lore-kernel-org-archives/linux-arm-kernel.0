From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 24 Aug 2014 23:34:31 -0300
Subject: [PATCH] ARM: dts: imx28-evk: Fix display duplicate name warning
In-Reply-To: <20140825022751.GI2540@dragon>
References: <1408672772-6365-1-git-send-email-festevam@gmail.com>
 <20140825022751.GI2540@dragon>
Message-ID: <CAOMZO5DySdUd8j583jEGCgX0oG8i8i1488M6MER-7Ys23fQ0Nw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 24, 2014 at 11:27 PM, Shawn Guo <shawn.guo@freescale.com> wrote:

> Unit address only makes sense where parent has #address-cells and
> #size-cells and the node itself has 'reg' property.

Ok, I followed the way arch/arm/boot/dts/imx28-tx28.dts implemented
the display node.

> I guess it's more appropriate to name the node in particular display
> device model that the node is defining?

Sorry, I did not understand. Could you please provide an example for
clarification?

Thanks,

Fabio Estevam
