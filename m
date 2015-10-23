From: robh+dt@kernel.org (Rob Herring)
Date: Fri, 23 Oct 2015 16:33:11 -0500
Subject: [PATCH v3 1/3] dt-bindings: Consolidate SRAM bindings from all
 vendors
In-Reply-To: <562A9300.5060105@kernel.org>
References: <1445564361-16974-1-git-send-email-k.kozlowski@samsung.com>
 <562A8ED8.6060904@kernel.org> <562A9300.5060105@kernel.org>
Message-ID: <CAL_JsqKPd2vRZO-Y3aZKmS=RpKsg5+9+UHSQbb3yObB_VM0Dcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 23, 2015 at 3:05 PM, Kukjin Kim <kgene@kernel.org> wrote:
> On 10/24/15 04:47, Kukjin Kim wrote:
>> On 10/23/15 10:39, Krzysztof Kozlowski wrote:
>>> SRAM bindings for various SoCs, using the mmio-sram genalloc
>>> API, are spread over different places - per SoC vendor. Since all of
>>> these are quite similar (they depend on mmio-sram) move them to a common
>>> place.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>> Cc: Heiko Stuebner <heiko@sntech.de>
>>> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
>>> Cc: Chen-Yu Tsai <wens@csie.org>
>>> Cc: Kukjin Kim <kgene@kernel.org>
>
> Acked-by: Kukjin Kim <kgene@kernel.org>
>
>>> Suggested-by: Rob Herring <robh+dt@kernel.org>
>>>
>> Applied with Heiko and Maxime's ack.
>>
> + Sudeep
>
> Oops, I can't because of ..bindings/arm/arm,scpi.txt, this series should
> be handled with "DT binding for ARM System Control and Power
> Interface(SCPI) protocol"

I'll take it after the merge window.

Rob
