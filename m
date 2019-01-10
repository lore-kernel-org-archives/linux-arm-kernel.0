Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D087C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:50:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FC662173B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D2ONvCuK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FC662173B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7E+X5+PbafQwwCEKTscjE7zzmh0fcTONyMzN+ZgABUc=; b=D2ONvCuKqBRQ2y
	cPHodHiAHRKBIlJ96OY+1BqIaFrNSGUuhnlR8m6P2Ad4b9G4rYWzXpn7KIyQkYXDlTefY2JAmIGnk
	Xlc/DUc3NEhTlYmOqUYuxD8tS6MF1KOgNEnx/mcZIo2xOUYjIyFetQXzM87N1ftbINnuLdFGcjZBi
	ocfdaRp+WzpaztiWYeq4AHO3ajgoGqRjXJ//S4Qbn3VvvALDNFACtmf70TYcxlEHP+xQx0e3vweKz
	fsSZoElHUZTyWTv80RjY9LJ3ON0LeUh5PrmWqLAE68lC6fo8SjtbYENLk1lQAh0kdZGfISqra6S02
	IgcVBXzgLKutmLuZtfng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghaib-0003Kz-GU; Thu, 10 Jan 2019 13:49:57 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghaiX-0003Jj-A9; Thu, 10 Jan 2019 13:49:54 +0000
Received: from wf0848.dip.tu-dresden.de ([141.76.183.80] helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1ghaiV-0003U8-Qk; Thu, 10 Jan 2019 14:49:51 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 4/5] arm64: dts: rockchip: Add NanoPC-T4 IR receiver
Date: Thu, 10 Jan 2019 14:49:51 +0100
Message-ID: <5091869.HhNVc33YkW@phil>
In-Reply-To: <a21283067b8d5132df430f3eca6a01ed9eebf1b2.1546981251.git.robin.murphy@arm.com>
References: <cover.1546981251.git.robin.murphy@arm.com>
 <a21283067b8d5132df430f3eca6a01ed9eebf1b2.1546981251.git.robin.murphy@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_054953_499921_087BC711 
X-CRM114-Status: UNSURE (   9.91  )
X-CRM114-Notice: Please train this message.
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

Am Dienstag, 8. Januar 2019, 22:57:26 CET schrieb Robin Murphy:
> In common with most Rockchip reference designs, NanoPC-T4 has a passive
> IR receiver connected to PWM3. In lieu of a specialised driver for
> PWM-based IR pulse measurement, running the pin as a GPIO with the basic
> driver works perfectly well.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

easy change and of course looks good.
As it doesn't apply due to coming after other changes, I'll have
to wait for v2 though.


Heiko



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
