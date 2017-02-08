From: markus.mayer@broadcom.com (Markus Mayer)
Date: Wed, 8 Feb 2017 09:29:20 -0800
Subject: [PATCH v6 1/2] dt-bindings: brcm: clocks: add binding for
 brcmstb-cpu-clk-div
In-Reply-To: <20170207184145.32brcgfvl66p5qtm@rob-hp-laptop>
References: <20170201232638.74396-1-code@mmayer.net>
 <20170201232638.74396-2-code@mmayer.net>
 <20170207184145.32brcgfvl66p5qtm@rob-hp-laptop>
Message-ID: <CAGt4E5t8rtgCgCTMcU1m0Gq9BgHckTUus3h8=j03NF0k4icwzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 February 2017 at 10:41, Rob Herring <robh@kernel.org> wrote:
> On Wed, Feb 01, 2017 at 03:26:37PM -0800, Markus Mayer wrote:
>> From: Markus Mayer <mmayer@broadcom.com>
>>
>> Add binding document for brcm,brcmstb-cpu-clk-div.
>>
>> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
>> ---
>>  .../bindings/clock/brcm,brcmstb-cpu-clk-div.txt    | 22 ++++++++++++++++++++++
>>  MAINTAINERS                                        |  1 +
>>  2 files changed, 23 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/clock/brcm,brcmstb-cpu-clk-div.txt
>
> Acked-by: Rob Herring <robh@kernel.org>

Actually, Stephen wasn't liking this too much.

See [1] for the conclusion of the ensuing discussion.

Regards,
-Markus

[1] https://lkml.org/lkml/2017/2/6/982
