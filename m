Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7E6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 19:24:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7244A20836
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 19:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dzjGeasT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7244A20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1aIhLfzVj3LdPO+HEZ6ti4Q/b+KXe6AhSSNUJsudPoo=; b=dzjGeasTZeBuVV
	WSJIDaxa8sVXcCkNGKL+B8l14OCzqTUp54OIg3SnDpmA7fPBhuVL+Z85osCg9chXC/f+SlLptGX7j
	R7zVtQI6DWwL1XzcquecMyYqe1Rkt9jQnmaXTbwEBYHUM6zcBfAmyjOqV677wELSboO4Bq0q+QtLK
	sY2Ji5t10I8OigZubSKW8CHlautuVuGKx32o7Md9UAuxRliU8+aRzNMPm5tSQxIf9AQL248NPAUFR
	iwNj5bi2wI4gmHjxRR5xTB5QneKg4SUrAnqzfD5Qnc7Ein6L/vB8A8y8yHB8XN/oeQH945lGvo0m0
	4cXciWjhez4iFBYVkciA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giOtX-0000ZF-Vh; Sat, 12 Jan 2019 19:24:35 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giOtT-0000Yq-VX; Sat, 12 Jan 2019 19:24:33 +0000
Received: from p54b26ced.dip0.t-ipconnect.de ([84.178.108.237]
 helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1giOtM-0006p6-8d; Sat, 12 Jan 2019 20:24:24 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Johan Jonker <jbx6244@gmail.com>
Subject: Re: [PATCH v2 5/7] ARM: dts: rockchip: add rk3066 vop display nodes
Date: Sat, 12 Jan 2019 20:24:23 +0100
Message-ID: <2822435.PgMx1mWbPR@phil>
In-Reply-To: <20181229133318.18128-6-jbx6244@gmail.com>
References: <20181229133318.18128-1-jbx6244@gmail.com>
 <20181229133318.18128-6-jbx6244@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_112432_162485_3B917D0D 
X-CRM114-Status: GOOD (  11.17  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, airlied@linux.ie, mturquette@baylibre.com,
 hjc@rock-chips.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, sboyd@kernel.org, robh+dt@kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Samstag, 29. Dezember 2018, 14:33:16 CET schrieb Johan Jonker:
> From: Mark Yao <mark.yao@rock-chips.com>
> 
> This patch adds the core display subsystem and vop nodes to rk3066.
> 
> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

applied for 5.1

Thanks
Heiko



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
