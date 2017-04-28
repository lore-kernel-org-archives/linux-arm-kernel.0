From: robh@kernel.org (Rob Herring)
Date: Fri, 28 Apr 2017 15:25:36 -0500
Subject: [PATCH v2 1/2] net: dsa: b53: Add compatible strings for the
 Cygnus-family BCM11360.
In-Reply-To: <20170425235357.7690-1-eric@anholt.net>
References: <20170425235357.7690-1-eric@anholt.net>
Message-ID: <20170428202536.pmo4ktea7bo6okbv@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 25, 2017 at 04:53:56PM -0700, Eric Anholt wrote:
> Cygnus is a small family of SoCs, of which we currently have
> devicetree for BCM11360 and BCM58300.  The 11360's B53 is mostly the
> same as 58xx, just requiring a tiny bit of setup that was previously
> missing.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> 
> v2: Reorder the entry in the docs (suggestion by Scott Branden), add
>     missing '"'
> 
>  Documentation/devicetree/bindings/net/dsa/b53.txt | 3 +++
>  drivers/net/dsa/b53/b53_srab.c                    | 2 ++
>  2 files changed, 5 insertions(+)

Everyone learns the hard way that specific compatibles are needed.

Acked-by: Rob Herring <robh@kernel.org>

Rob
