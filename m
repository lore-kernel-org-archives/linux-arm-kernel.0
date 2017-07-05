From: robh@kernel.org (Rob Herring)
Date: Wed, 5 Jul 2017 09:20:15 -0500
Subject: [PATCH] dt-bindings: amlogic: add unstable statement
In-Reply-To: <20170628145343.25443-1-khilman@baylibre.com>
References: <20170628145343.25443-1-khilman@baylibre.com>
Message-ID: <20170705142015.tmlmes5lobadndsy@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 28, 2017 at 07:53:43AM -0700, Kevin Hilman wrote:
> Due to the lack of documentation on this SoC family, discovery of new
> features, and correcting of previous misunderstandings is expected, so
> it's unrealistic to expect any form of stable bindings for this SoC
> family.  Make that clear inthe binding documentation.

s/inthe/in the/

> 
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.txt | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

I've yet to see anyone remove an unstable tag and I'd rather see these 
for individual bindings than for the platform as a whole. In the end, 
it's a platform maintainers decision whether to accept compatibility 
breakage regardless of some text that probably no one reads.

In any case,

Acked-by: Rob Herring <robh@kernel.org>
