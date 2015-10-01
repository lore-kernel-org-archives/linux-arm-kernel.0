From: robh@kernel.org (Rob Herring)
Date: Thu, 1 Oct 2015 08:26:02 -0500
Subject: [RESEND][PATCH v3 5/9] of: Add Boundary Devices Inc. vendor prefix
In-Reply-To: <1443620806-14792-6-git-send-email-gary.bisson@boundarydevices.com>
References: <1441645069-27263-1-git-send-email-gary.bisson@boundarydevices.com>
 <1443620806-14792-1-git-send-email-gary.bisson@boundarydevices.com>
 <1443620806-14792-6-git-send-email-gary.bisson@boundarydevices.com>
Message-ID: <CAL_JsqLTvh8MKqhyZ1KdPttkj7gFGaHt1-1ULEYKc0jCy+YB6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 30, 2015 at 8:46 AM, Gary Bisson
<gary.bisson@boundarydevices.com> wrote:
> This patch adds the vendor prefix for Boundary Devices Inc. which is a
> supplier of ARM-based single board computers and System-on-Modules for
> the general embedded market.
>
> Website: http://boundarydevices.com/
>
> Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 82d2ac9..eca468d 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -34,6 +34,7 @@ avago Avago Technologies
>  avic   Shanghai AVIC Optoelectronics Co., Ltd.
>  axis   Axis Communications AB
>  bosch  Bosch Sensortec GmbH
> +boundary       Boundary Devices Inc.
>  brcm   Broadcom Corporation
>  buffalo        Buffalo, Inc.
>  calxeda        Calxeda
> --
> 2.5.3
>
