From: robh+dt@kernel.org (Rob Herring)
Date: Tue, 10 Nov 2015 14:09:06 -0600
Subject: [PATCH v3 1/7] of: Add vendor prefix for Advantech Corporation
In-Reply-To: <1447178408-26982-2-git-send-email-akshay.bhat@timesys.com>
References: <1447178408-26982-1-git-send-email-akshay.bhat@timesys.com>
 <1447178408-26982-2-git-send-email-akshay.bhat@timesys.com>
Message-ID: <CAL_JsqJ==2cM9q-8OVDiGmW_+tU0CNKmUgDz3NafNvdut4Q2=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 10, 2015 at 12:00 PM, Akshay Bhat <akshay.bhat@timesys.com> wrote:
> This patch adds vendor prefix for Advantech Corporation.
>
> Website: http://www.advantech.com/
> Signed-off-by: Akshay Bhat <akshay.bhat@timesys.com>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 55df1d4..5134b24 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -10,6 +10,7 @@ ad    Avionic Design GmbH
>  adapteva       Adapteva, Inc.
>  adh    AD Holdings Plc.
>  adi    Analog Devices, Inc.
> +advantech      Advantech Corporation
>  aeroflexgaisler        Aeroflex Gaisler AB
>  al     Annapurna Labs
>  allwinner      Allwinner Technology Co., Ltd.
> --
> 2.6.3
>
