Return-Path: <SRS0=QUhG=Q7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF23DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 05:29:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6B4E2083E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 05:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NjuxEGAW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6B4E2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tkos.co.il
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:
	In-reply-to:Subject:To:From:References:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=EEYXsS9QGIpE2GsfExITPpkzVt/Rm6n5PkeqIopU5Eg=; b=NjuxEGAWaMHPgA79UYv7Xy/ciE
	RvEV7H052kRGyTS+kNf1jDxO5K3Es0mu1acDxz/7xJndBkK7Kz6WAjD4Jm0S1IaIfhv2Nohmj004B
	KaDZYWyh6L8zqNmTfiNLaYyi/OFHjy5js+08Yl4k5o7070X/O1qwJ7CXIBIZQMEpkChYAxyZVBNJz
	UV4DOBjH9YLb8YhjyZZglPnNw52qz4EVlfVvDPYF/l/wqY9p09oLTrRyAAxrQXRSg+W8HKSRyU3hm
	QNjKmFnk4EzVKcJpFywHEKToVCxdmFB2pzayVqrv0smILU7LEIYe7Rt/7CPWlrrKlf/KO9uXsIv/r
	xVTpxEnw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxmLq-0006F4-Rq; Sun, 24 Feb 2019 05:29:22 +0000
Received: from guitar.tcltek.co.il ([192.115.133.116] helo=mx.tkos.co.il)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxmLm-0006EI-Sz
 for linux-arm-kernel@lists.infradead.org; Sun, 24 Feb 2019 05:29:21 +0000
Received: from tarshish (unknown [10.0.8.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx.tkos.co.il (Postfix) with ESMTPS id 2887A44046E;
 Sun, 24 Feb 2019 07:29:10 +0200 (IST)
References: <20190222145356.23072-1-miquel.raynal@bootlin.com>
 <20190222145356.23072-5-miquel.raynal@bootlin.com>
User-agent: mu4e 1.0; emacs 26.1
From: Baruch Siach <baruch@tkos.co.il>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 4/5] arm64: dts: marvell: armada-8040-clearfog: Drop
 non-existent SATA port
In-reply-to: <20190222145356.23072-5-miquel.raynal@bootlin.com>
Date: Sun, 24 Feb 2019 07:29:09 +0200
Message-ID: <87tvgt7o0q.fsf@tarshish>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190223_212919_170840_F28FD94E 
X-CRM114-Status: GOOD (  16.11  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>,
 Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org,
 Marc Zyngier <marc.zyngier@arm.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Hans de Goede <hdegoede@redhat.com>,
 Rob Herring <robh+dt@kernel.org>, Antoine Tenart <antoine.tenart@bootlin.com>,
 Jens Axboe <axboe@kernel.dk>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-ide@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Miquel,

On Fri, Feb 22 2019, Miquel Raynal wrote:

> There is no CP110 SATA port available on the 8040 Clearfog A8k, SATA
> may be used thanks to a mPCIe -> SATA extension board only. Hence, the
> cp1_sata0 node must be removed from the device tree.

Not true. You can use the mini PCIe serdes as SATA directly if you
configure it as such. You only need to invert the serdes Rx pair
polarity. This is the default configuration for the Clearfog GT-8K CON3
mini-PCIe slot (CP1, lane #0) in current mainline U-Boot. I verified
that this setup works on Clearfog GT-8K.

This patch would break mini PCIe direct SATA.

baruch

>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
> index 5b4a9609e31f..caabbd3a85a8 100644
> --- a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
> @@ -333,11 +333,6 @@
>  	};
>  };
>
> -&cp1_sata0 {
> -	pinctrl-0 = <&cp0_pci1_reset_pins>;
> -	status = "okay";
> -};
> -
>  &cp1_mdio {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&cp1_ge_mdio_pins>;


--
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
