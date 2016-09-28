From: minyard@acm.org (Corey Minyard)
Date: Wed, 28 Sep 2016 13:37:48 -0500
Subject: [PATCH] dt-bindings: ipmi: move all documentation under
 bindings/ipmi/
In-Reply-To: <1475071661-1342-1-git-send-email-clg@kaod.org>
References: <1475071661-1342-1-git-send-email-clg@kaod.org>
Message-ID: <683e77fd-9311-edbb-af0b-e45a57b11212@acm.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ok, applied.  I folded it in to the previous patch to avoid the checkpatch
error :).  And it didn't seem important to keep it separate.

And I added Rob's Ack.

Thanks,

-corey

On 09/28/2016 09:07 AM, C?dric Le Goater wrote:
> Signed-off-by: C?dric Le Goater <clg@kaod.org>
> ---
>   .../devicetree/bindings/{char => }/ipmi/aspeed,ast2400-bt-bmc.txt         | 0
>   Documentation/devicetree/bindings/{ipmi.txt => ipmi/ipmi-smic.txt}        | 0
>   2 files changed, 0 insertions(+), 0 deletions(-)
>   rename Documentation/devicetree/bindings/{char => }/ipmi/aspeed,ast2400-bt-bmc.txt (100%)
>   rename Documentation/devicetree/bindings/{ipmi.txt => ipmi/ipmi-smic.txt} (100%)
>
> diff --git a/Documentation/devicetree/bindings/char/ipmi/aspeed,ast2400-bt-bmc.txt b/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-bt-bmc.txt
> similarity index 100%
> rename from Documentation/devicetree/bindings/char/ipmi/aspeed,ast2400-bt-bmc.txt
> rename to Documentation/devicetree/bindings/ipmi/aspeed,ast2400-bt-bmc.txt
> diff --git a/Documentation/devicetree/bindings/ipmi.txt b/Documentation/devicetree/bindings/ipmi/ipmi-smic.txt
> similarity index 100%
> rename from Documentation/devicetree/bindings/ipmi.txt
> rename to Documentation/devicetree/bindings/ipmi/ipmi-smic.txt
