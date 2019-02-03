Return-Path: <SRS0=H3s0=QK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F331C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 09:06:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 319662083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 09:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oIShWC42"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 319662083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=w7RRcQPSP1vUl0LwhfZ+DmSNSGGZt1HSXBjYOmOBt+A=; b=oIShWC42pyC8mJ
	6cLt7zT31aLoBOhewmYkLI2fVtiRHabZJR6W8+AH4lj1i6Jf5jzJ2GQ73Q2/pnGOoAVLhEFCP/uzW
	i7CCNuHI8zQbmLJHkZkA5sXRWP6QM8c4R7LCdNdowOH70aUPmwNgdlc2Z+PqmYDBorSHd/5Khh3VS
	Sr97XOwwvBSA4TaBEogu7mO/ukMnrwVZS45ZeBCSZMonP12VeWB85OEcv3RkB5x12R+x2/JYqY80a
	Dx/A+sgzt8tSj8B+vbmM5mn6GJdiFEzBJlGMcxfp41MLErfv/RtjbImKxQnofEdIqg6LYg7F3EfQk
	sfa5HoqgwkyET0j70R7A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqDjh-0000h7-Oe; Sun, 03 Feb 2019 09:06:45 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqDjd-0000gH-Us; Sun, 03 Feb 2019 09:06:43 +0000
Received: from [164.15.244.47] (helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1gqDjb-0001LR-FP; Sun, 03 Feb 2019 10:06:39 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: Re: [PATCH] arm64: dts: rockchip: add HDMI sound node for
 rk3328-rock64
Date: Sun, 03 Feb 2019 10:06:38 +0100
Message-ID: <1970132.3b67tCGWFf@phil>
In-Reply-To: <20190202043444.9308-1-katsuhiro@katsuster.net>
References: <20190202043444.9308-1-katsuhiro@katsuster.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190203_010642_162292_7CCBC685 
X-CRM114-Status: GOOD (  19.19  )
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
Cc: linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Samstag, 2. Februar 2019, 05:34:44 CET schrieb Katsuhiro Suzuki:
> This patch adds HDMI sound (I2S0) node and remove dma properties
> from UART2 node for rock64.
> 
> The DMAC of rk3328 can use 8 channels at same time. Currently, total
> 7 channels are used as follows:
>   - I2S1  2ch
>   - UART2 2ch
>   - SPDIF 1ch
>   - SPI0  2ch
> 
> HDMI audio using I2S0 that requires 2ch but DMAC has only 1 channel.
> 
> UART2 can work without DMA resources, so this patch removes dma
> allocation for UART2 and reuses it to I2S0.

I don't follow that description. How can i2s0 re-use the uart2 dma channels?
Looking at the dma table in the TRM, uart2 has channels 6+7 while i2s0
uses channels 11+12. They should just run concurrently?

> 
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> ---
>  .../arm64/boot/dts/rockchip/rk3328-rock64.dts | 24 ++++++++++++++++++-
>  arch/arm64/boot/dts/rockchip/rk3328.dtsi      |  1 +
>  2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
> index 2157a528276b..e21645aa3fa5 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
> @@ -68,7 +68,8 @@
>  	sound {
>  		compatible = "audio-graph-card";
>  		label = "rockchip,rk3328";
> -		dais = <&i2s1_p0
> +		dais = <&i2s0_p0
> +			&i2s1_p0
>  			&spdif_p0>;
>  	};
>  
> @@ -141,6 +142,12 @@
>  
>  &hdmi {
>  	status = "okay";
> +
> +	port@0 {
> +		hdmi_p0_0: endpoint {
> +			remote-endpoint = <&i2s0_p0_0>;
> +		};
> +	};
>  };
>  
>  &hdmiphy {
> @@ -256,6 +263,18 @@
>  	};
>  };
>  
> +&i2s0 {
> +	status = "okay";
> +
> +	i2s0_p0: port {
> +		i2s0_p0_0: endpoint {
> +			dai-format = "i2s";
> +			mclk-fs = <256>;
> +			remote-endpoint = <&hdmi_p0_0>;
> +		};
> +	};
> +};
> +
>  &i2s1 {
>  	status = "okay";
>  
> @@ -343,6 +362,9 @@
>  
>  &uart2 {
>  	status = "okay";
> +
> +	/delete-property/ dmas;
> +	/delete-property/ dma-names;
>  };
>  
>  &u2phy {
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> index 84f14b132e8f..374b5da93a35 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> @@ -665,6 +665,7 @@
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&hdmi_cec &hdmii2c_xfer &hdmi_hpd>;
>  		rockchip,grf = <&grf>;
> +		#sound-dai-cells = <0>;

please make that a separate patch


Heiko



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
