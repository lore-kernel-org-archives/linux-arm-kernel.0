Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14B3C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:11:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A19BB20879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fHsdgxYy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A19BB20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=s0k6SRHetolwH6Od4bvMp/mDWOuVGb5SuKYYzdozjp0=; b=fHsdgxYyZ9ogqB
	zweAii2JGtykNvg+Z1sEi1ZpiBwNd6tWT7a7D5+Y/DKlJmVwdZUXIxEofCaga91QFpIAKkz3Ikd5K
	hU7XnI/nnlLUibkP7F7t3iUEi4AfbvEoZdQ7x6G4zoG8xa9/oquOOFbtz2QKshtld1SKaG/YHrSTi
	QK9HUXc03e5UXFHqjhLgQw+pX21nexGqujW3MINqEHRMlGI71GFqKl2KMfi4QAb61TsMEoksmsj5/
	KormJ3Z2DMbrcrxJA9v1fHorckCSY5lHDuX6CEVTrF0LVufGpxPWXXHocys9JX9BTy4KXMVN3LmXi
	Brkc0yEp+2gekwTI7LHg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWnRg-00081l-3S; Tue, 11 Dec 2018 19:11:52 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWnRb-0007nb-Hy; Tue, 11 Dec 2018 19:11:49 +0000
Received: from p5b127a5a.dip0.t-ipconnect.de ([91.18.122.90]
 helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1gWnRL-0007y1-1x; Tue, 11 Dec 2018 20:11:31 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v3 2/7] arm64: dts: rockchip: rock960: Add on-board LED
 support
Date: Tue, 11 Dec 2018 20:11:29 +0100
Message-ID: <2253614.B1JKRkMpsS@phil>
In-Reply-To: <20181029094245.7886-3-manivannan.sadhasivam@linaro.org>
References: <20181029094245.7886-1-manivannan.sadhasivam@linaro.org>
 <20181029094245.7886-3-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_111148_138365_89D47877 
X-CRM114-Status: UNSURE (   9.85  )
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
Cc: robh@kernel.org, daniel.thompson@linaro.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linus.walleij@linaro.org,
 linux-soc@vger.kernel.org, michal.simek@xilinx.com, xuwei5@hisilicon.com,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 nicolas.dechesne@linaro.org, koen.kooi@linaro.org,
 linux-arm-kernel@lists.infradead.org, pavel@ucw.cz, andy.gross@linaro.org,
 amit.kucheria@linaro.org, ezequiel@collabora.com, linux-leds@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Montag, 29. Oktober 2018, 10:42:40 CET schrieb Manivannan Sadhasivam:
> Add on-board LED support for Rock960 board based on the following
> standard used by rest of the 96Boards:
> 
> green:user1  default-trigger: heartbeat
> green:user2  default-trigger: mmc0/disk-activity(onboard-storage)
> green:user3  default-trigger: mmc1 (SD-card)
> green:user4  default-trigger: none, panic-indicator
> yellow:wlan  default-trigger: phy0tx
> blue:bt      default-trigger: hci0-power
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

applied for 4.21

Thanks
Heiko



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
