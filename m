From: robh@kernel.org (Rob Herring)
Date: Wed, 9 Nov 2016 12:26:19 -0600
Subject: [PATCH 1/3] ipmi/bt-bmc: change compatible node to 'aspeed,
 ast2400-ibt-bmc'
In-Reply-To: <1478073426-3714-2-git-send-email-clg@kaod.org>
References: <1478073426-3714-1-git-send-email-clg@kaod.org>
 <1478073426-3714-2-git-send-email-clg@kaod.org>
Message-ID: <20161109182619.odl5f6hffiyfej4t@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 02, 2016 at 08:57:04AM +0100, C?dric Le Goater wrote:
> The Aspeed SoCs have two BT interfaces : one is IPMI compliant and the
> other is H8S/2168 compliant.
> 
> The current ipmi/bt-bmc driver implements the IPMI version and we
> should reflect its nature in the compatible node name using
> 'aspeed,ast2400-ibt-bmc' instead of 'aspeed,ast2400-bt-bmc'. The
> latter should be used for a H8S interface driver if it is implemented
> one day.
> 
> Signed-off-by: C?dric Le Goater <clg@kaod.org>
> ---
>  .../ipmi/{aspeed,ast2400-bt-bmc.txt => aspeed,ast2400-ibt-bmc.txt}    | 4 ++--

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/char/ipmi/bt-bmc.c                                            | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>  rename Documentation/devicetree/bindings/ipmi/{aspeed,ast2400-bt-bmc.txt => aspeed,ast2400-ibt-bmc.txt} (85%)
