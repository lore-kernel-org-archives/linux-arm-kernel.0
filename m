From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Wed, 7 Sep 2016 16:51:55 +0200
Subject: [PATCH 5/6] ARM: dts: Add NextThing GR8 dtsi
In-Reply-To: <20160831081817.5191-6-maxime.ripard@free-electrons.com>
References: <20160831081817.5191-1-maxime.ripard@free-electrons.com>
 <20160831081817.5191-6-maxime.ripard@free-electrons.com>
Message-ID: <CABxcv=kJCuP==QVRqyuoORSoWKAEqXmt5iRjdvDcCcr4MSm0gQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Maxime,

On Wed, Aug 31, 2016 at 10:18 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

[snip]

> +
> +#include "skeleton.dtsi"
> +

The skeleton.dtsi has been deprecated and shouldn't be used in new DTS files:

http://www.spinics.net/lists/arm-kernel/msg528080.html

Best regards,
Javier
