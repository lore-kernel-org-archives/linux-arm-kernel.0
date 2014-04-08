From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 08 Apr 2014 09:35:16 +0200
Subject: [PATCH] of: add vendor prefix for I2SE GmbH
In-Reply-To: <1396514029-5769-1-git-send-email-stefan.wahren@i2se.com>
References: <1396514029-5769-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <5343A6B4.9030309@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 03.04.2014 10:33, schrieb Stefan Wahren:
> Add i2se to the list of DT vendor prefixes.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index e9d19e2..f27f6c9 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -45,6 +45,7 @@ haoyu	Haoyu Microelectronic Co. Ltd.
>  hisilicon	Hisilicon Limited.
>  honeywell	Honeywell
>  hp	Hewlett Packard
> +i2se	I2SE GmbH
>  ibm	International Business Machines (IBM)
>  idt	Integrated Device Technologies, Inc.
>  img	Imagination Technologies Ltd.

i forgot to mention that my patch is an addition to this patch:

https://git.linaro.org/people/shawn.guo/linux-2.6.git/commit/df0355f2b06caf8e7948534c278114bafc2f72e0

The prefix i2se is used in imx28-duckbill.dts.

Kind regards
Stefan Wahren
