Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C01C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 22:15:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB5BD20883
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 22:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uwSAkKnG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB5BD20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RF2yHwtCB6XwGOds6sJsxYUgnpKkHTT6M0khNJUzzyc=; b=uwSAkKnGs1GRkR
	DUwoIz/T5T/dTD8ggYehxz08C97FIHbH8cJcjyZhYLJO6wHmy9NsAPNBE2da8ArlH2P2MAQ1cfzvM
	aaV4Po4pjgfMtvNOMpKaWoiyTlW3zUecCWlUlKCOCXvjZRpqCmF+AdpR+793cnVMN6E66vnDdvudH
	Ij60/EgZqHOkkbMqp/a/fFnvyg7qHsH047F0AOd9oppx3xBphENGp1+vL/6tc3MOsEufLs9Iti2dU
	W7cW8qUX7pxRxWqPpqxWG6rPBeesobQfh7lpdPLaAA0x9eXR3qJEP1aYq3rPle2Q4OSq/KKAMFBOe
	rQ1E27qNxb3BMzVS+TSQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggzex-0006yr-10; Tue, 08 Jan 2019 22:15:43 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggzes-0006y2-BJ; Tue, 08 Jan 2019 22:15:40 +0000
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32]
 helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1ggzep-0002VK-1K; Tue, 08 Jan 2019 23:15:35 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 2/5] arm64: dts: rockchip: Add DT for NanoPi M4
Date: Tue, 08 Jan 2019 23:15:34 +0100
Message-ID: <1755553.je4OVlYtzY@phil>
In-Reply-To: <324b75bbeef2552ddde62f4e1834ac908a45bebd.1546981251.git.robin.murphy@arm.com>
References: <cover.1546981251.git.robin.murphy@arm.com>
 <324b75bbeef2552ddde62f4e1834ac908a45bebd.1546981251.git.robin.murphy@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_141538_541233_0EFC02EB 
X-CRM114-Status: GOOD (  20.94  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-rockchip@lists.infradead.org, tomeu.vizoso@collabora.com,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Robin,

Am Dienstag, 8. Januar 2019, 22:57:24 CET schrieb Robin Murphy:
> There are a number of subtle differences between the nanopi4 variants,
> and where they disagree, the common DTSI currently follows the details
> of NanoPi M4. In order to improve matters even more, let's add a
> separate DTS for the M4 to which we can start splitting things out
> appropriately. The third variant, NanoPi NEO4, is a lot closer to the M4
> than either is to the larger T4, so arguably could get away with just
> sharing the M4 DT for now (plus I have neither of the smaller boards to
> actually test with).
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

I'm not sure if Rob actually checks the devicetree list or relies on
patches Cc'ed directly to him for binding review, so you might want
to add the 2 dt maintainers explicitly.

> ---
>  .../devicetree/bindings/arm/rockchip.yaml      |  5 +++++
>  arch/arm64/boot/dts/rockchip/Makefile          |  1 +
>  .../boot/dts/rockchip/rk3399-nanopi-m4.dts     | 18 ++++++++++++++++++
>  3 files changed, 24 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index bcc60c492a12..b4756e0cb7d0 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -92,6 +92,11 @@ properties:
>            - const: friendlyarm,nanopc-t4
>            - const: rockchip,rk3399
>  
> +      - description: FriendlyElec NanoPi M4
> +        items:
> +          - const: friendlyarm,nanopi-m4
> +          - const: rockchip,rk3399
> +

When we hashed out the Rockchip yaml thingy, there also
came up the possibility of grouping the similar boards together
into an enum, see the rk3399-firefly or the rk3288-evb-* for example.

So the binding for both could possibly become:

      - description: FriendlyElec NanoPi
        items:
	  - enum:
          	- friendlyarm,nanopi-m4
          	- friendlyarm,nanopi-t4
          - const: rockchip,rk3399

We didn't come up with a hard rule for all cases, but the
Nano PI feels like it qualifies ;-)


Heiko



>        - description: GeekBuying GeekBox
>          items:
>            - const: geekbuying,geekbox
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index 1c7406111dfd..91a669378605 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -17,6 +17,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-kevin.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-scarlet-inx.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-scarlet-kd.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopc-t4.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopi-m4.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-puma-haikou.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock960.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4.dts b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4.dts
> new file mode 100644
> index 000000000000..8d3f0ba29c72
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4.dts
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * FriendlyElec NanoPi M4 board device tree source
> + *
> + * Copyright (c) 2018 FriendlyElec Computer Tech. Co., Ltd.
> + * (http://www.friendlyarm.com)
> + *
> + * Copyright (c) 2018 Collabora Ltd.
> + * Copyright (c) 2019 Arm Ltd.
> + */
> +
> +/dts-v1/;
> +#include "rk3399-nanopi4.dtsi"
> +
> +/ {
> +	model = "FriendlyElec NanoPi M4";
> +	compatible = "friendlyarm,nanopi-m4", "rockchip,rk3399";
> +};
> 





_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
