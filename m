From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 25 Apr 2017 12:35:08 +0300
Subject: [PATCH 1/2] net: dsa: b53: Add compatible strings for the
 Cygnus-family BCM11360.
In-Reply-To: <20170424215022.30382-2-eric@anholt.net>
References: <20170424215022.30382-1-eric@anholt.net>
 <20170424215022.30382-2-eric@anholt.net>
Message-ID: <f2d8edf5-53fc-52b6-e316-142d4130b310@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

On 4/25/2017 12:50 AM, Eric Anholt wrote:

> Cygnus is a small family of SoCs, of which we currently have
> devicetree for BCM11360 and BCM58300.  The 11360's B53 is mostly the
> same as 58xx, just requiring a tiny bit of setup that was previously
> missing.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  Documentation/devicetree/bindings/net/dsa/b53.txt | 3 +++
>  drivers/net/dsa/b53/b53_srab.c                    | 2 ++
>  2 files changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/net/dsa/b53.txt b/Documentation/devicetree/bindings/net/dsa/b53.txt
> index d6c6e41648d4..49c93d3c0839 100644
> --- a/Documentation/devicetree/bindings/net/dsa/b53.txt
> +++ b/Documentation/devicetree/bindings/net/dsa/b53.txt
> @@ -29,6 +29,9 @@ Required properties:
>        "brcm,bcm58625-srab"
>        "brcm,bcm88312-srab" and the mandatory "brcm,nsp-srab string
>
> +  For the BCM11360 SoC, must be:
> +      "brcm,bcm11360-srab" and the mandatory "brcm,cygnus-srab string

     Missing closing quote here and above?

[...]

MBR, Sergei
