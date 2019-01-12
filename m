Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06B4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 20:17:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC320206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 20:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Yey+poDm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC320206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2YKXDBw8HBE3ahfG0BhfVA0wfeevkbXwxalKhM3l/A0=; b=Yey+poDmUN+Whh
	piJxZnX1LCBbgTZIt6Sbh7PJezcPkwh1o+zMXTsPcuYa381DQ8y+t3WOh98SPoPVDTHNuIlRXCYjr
	PGpjs6AHp3kFwbdfKub4FCtP2RnuK3BqvfvFS42jCbOIzLtBARXMO9bgutu6yd4UxCKmsF2Nb1uRN
	hO3ZhoaVCOnx0xK8G9WGEaVaaK/JEpdXnQl00R4s5sF7HK7f/QiWVZ2yv3FL7qRAxu66kOh9ZKLVy
	maKWKZnv+7ygFmIA5rcfI+jZ3lJAB28tzSmMVf+zBB/Kr2/nMUv+MwbmfK8UlCjgzxGrP6Ke0ihbt
	TQdE/AGkvcK2PM7fPJvQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giPiS-0001Ft-L7; Sat, 12 Jan 2019 20:17:12 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giPiP-0001F8-7u; Sat, 12 Jan 2019 20:17:11 +0000
Received: from p54b26ced.dip0.t-ipconnect.de ([84.178.108.237]
 helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1giPiF-00070n-HS; Sat, 12 Jan 2019 21:16:59 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Otavio Salvador <otavio@ossystems.com.br>
Subject: Re: [PATCH 4/4] ARM: dts: rv1108: Add support for rv1108-elgin-r1
 board
Date: Sat, 12 Jan 2019 21:16:58 +0100
Message-ID: <2576878.pKSbgTzd5o@phil>
In-Reply-To: <20190104014023.17973-4-otavio@ossystems.com.br>
References: <20190104014023.17973-1-otavio@ossystems.com.br>
 <20190104014023.17973-4-otavio@ossystems.com.br>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_121709_464363_6E43B2B2 
X-CRM114-Status: GOOD (  10.26  )
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
Cc: Jason Zhu <jason.zhu@rock-chips.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Rob Herring <robh+dt@kernel.org>, Vicent Chi <vicent.chi@rock-chips.com>,
 Olof Johansson <olof@lixom.net>, Andy Yan <andy.yan@rock-chips.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Philipp Tomsic <philipp.tomsich@theobroma-systems.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Freitag, 4. Januar 2019, 02:40:23 CET schrieb Otavio Salvador:
> rv1108-elgin-r1 board is based on Rockchip RV1108 SoC.
> 
> Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>

applied all 4 patches (including the vendor-prefix) for 5.1

I've rearranged some minor properties in the board-dts to follow
alphabetical ordering (emmc and gmac).


Thanks
Heiko



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
