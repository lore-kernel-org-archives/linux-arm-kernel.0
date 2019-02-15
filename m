Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4B0C4151A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:47:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06E0D222F3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ljsUnHXi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06E0D222F3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XDXaQuY292G6Xml5FjSyyXBHJ30DowhI5HbT3fmxc5I=; b=ljsUnHXiJRRiAi
	Mbyp1ePyMVG8u842fYg1QKO7asVYembksXCBBFQkPQo+NiUTZWdcF68MSVpqbtau0yST1cP7+xGpD
	DjD7EjQVtZlUVjekEsps788CIW1iayWrIABCLk9ui56DadnK77G9cFmBJsUPPewHlPQvhoNhoke2b
	tKk8VOkN3pNRjRJG6AiZdzIPVbN8AEkDUUZyBK6VZsckidph839IEAirdnvnhmTig1nhtbA6ZVlC1
	EKcV+TfLGv4+oaywZ5V4VcGvHw29MQ1E9mUCkgAsbC0kfTAW2LWy5fiW6XqvZ+Z1HOj5CfHSkvtl9
	XZ1zVWjpf3T/fdJT2ELw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guZxh-0001Vy-Ed; Fri, 15 Feb 2019 09:39:13 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guZxd-0001Up-2r; Fri, 15 Feb 2019 09:39:10 +0000
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32]
 helo=diego.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1guZxb-0000J0-9F; Fri, 15 Feb 2019 10:39:07 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v2] arm64: dts: rockchip: Add on-board WiFi/BT support for
 Rock960 boards
Date: Fri, 15 Feb 2019 10:39:06 +0100
Message-ID: <1797728.tnt5FPHN1h@diego>
In-Reply-To: <20190215045648.26380-1-manivannan.sadhasivam@linaro.org>
References: <20190215045648.26380-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_013909_274653_E26D3DB7 
X-CRM114-Status: GOOD (  10.63  )
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
Cc: tom@vamrs.com, mani@kernel.org, linux-kernel@vger.kernel.org, dev@vamrs.com,
 linux-rockchip@lists.infradead.org, pbrobinson@gmail.com,
 ezequiel@collabora.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Freitag, 15. Februar 2019, 05:56:48 CET schrieb Manivannan Sadhasivam:
> Add on-board WiFi/BT support for Rock960 boards such as Rock960 based
> on AP6356S and Ficus based on AP6354 wireless modules.
> 
> Firmwares for the respective boards are available here:
> 
> http://people.linaro.org/~manivannan.sadhasivam/rock960_wifi/
> http://people.linaro.org/~manivannan.sadhasivam/ficus_wifi/
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>


> +&sdio0 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	clock-frequency = <50000000>;
> +	bus-width = <4>;
> +	cap-sdio-irq;
> +	cap-sd-highspeed;
> +	no-emmc;
> +	keep-power-in-suspend;
> +	mmc-pwrseq = <&sdio_pwrseq>;
> +	non-removable;
> +	num-slots = <1>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdio0_bus4 &sdio0_cmd &sdio0_clk>;
> +	sd-uhs-sdr104;

I've dropped the no-emmc and num-slots properties and applied
the result for 5.1

Thanks
Heiko



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
