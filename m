Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6211C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 00:46:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B234F2147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 00:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i6FXp8Yt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B234F2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZSqf+mMbzNmqlde/ep0j4fM3rg3o7p6lvzhRXwK2wiE=; b=i6FXp8Ytrkpxpa
	ApveMOv7AGZa73ZbzXmD9d2olJc9xS1uaGS5GJvTcZxB7UYgJY+vgYzLCTskxWjziDr1Icb7AXJgC
	Pj6unjFI273kdfmc3GObHpZfnbQ4NoeZtddC+c7m1tFLq0JWJhnHmCXHDd5jJf3QRsWgsj8m2urdw
	mXm1njRp245yLo1LkkT7lcaoK/C2T5djp9OUKGbAUQBtArclmi6nwUlT4ySpe7qkmj1Vz31ffkB0T
	Vj0SFlax3rVi8mPLiBVe1YPH3HR182hE3PtfUd6AH9cvVoTdJz7t4+MvzCh03Fwk9KqBde3/4f+jN
	ZDgzAJh1tf7HohqXxh1w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwG23-0007Ca-DX; Wed, 20 Feb 2019 00:46:39 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwG1y-0007BM-CL; Wed, 20 Feb 2019 00:46:35 +0000
X-UUID: 3bb8654222e6499eaee812ff000daa9f-20190219
X-UUID: 3bb8654222e6499eaee812ff000daa9f-20190219
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw02.mediatek.com
 (envelope-from <houlong.wei@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 511402056; Tue, 19 Feb 2019 16:46:25 -0800
Received: from mtkmbs08n1.mediatek.inc (172.21.101.55) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 19 Feb 2019 16:46:24 -0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs08n1.mediatek.inc
 (172.21.101.55) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Wed, 20 Feb 2019 08:46:22 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 20 Feb 2019 08:46:20 +0800
Message-ID: <1550623580.16735.3.camel@mhfsdcap03>
Subject: Re: [PATCH 06/14] media: platform: fix several typos
From: houlong wei <houlong.wei@mediatek.com>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Date: Wed, 20 Feb 2019 08:46:20 +0800
In-Reply-To: <362e90167292e8d0c03a8d0753cc26b89549d854.1550518128.git.mchehab+samsung@kernel.org>
References: <f235ba60b2b7e5fba09d3c6b0d5dbbd8a86ea9b9.1550518128.git.mchehab+samsung@kernel.org>
 <362e90167292e8d0c03a8d0753cc26b89549d854.1550518128.git.mchehab+samsung@kernel.org>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_164634_428391_53F7B3C2 
X-CRM114-Status: UNSURE (   8.48  )
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
Cc: Andrew-CT Chen =?UTF-8?Q?=28=E9=99=B3=E6=99=BA=E8=BF=AA=29?=
 <Andrew-CT.Chen@mediatek.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Minghsiu Tsai =?UTF-8?Q?=28=E8=94=A1=E6=98=8E=E4=BF=AE=29?=
 <Minghsiu.Tsai@mediatek.com>, Heiko Stuebner <heiko@sntech.de>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Patrice Chotard <patrice.chotard@st.com>, Andrzej Hajda <a.hajda@samsung.com>,
 "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Michal Simek <michal.simek@xilinx.com>,
 Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Chen-Yu Tsai <wens@csie.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 "linux-stm32@st-md-mailman.stormreply.com"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 Kukjin Kim <kgene@kernel.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Kamil Debski <kamil@wypas.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@st.com>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 Mauro Carvalho
 Chehab <mchehab@infradead.org>, Benoit Parrot <bparrot@ti.com>,
 Jeongtae Park <jtp.park@samsung.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 Jacek Anaszewski <jacek.anaszewski@gmail.com>,
 Yong Deng <yong.deng@magewell.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Hugues Fruchet <hugues.fruchet@st.com>,
 Tiffany Lin =?UTF-8?Q?=28=E6=9E=97=E6=85=A7=E7=8F=8A=29?=
 <tiffany.lin@mediatek.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Hyun Kwon <hyun.kwon@xilinx.com>, Jacob chen <jacob2.chen@rock-chips.com>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Jean-Christophe Trotin <jean-christophe.trotin@st.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Niklas =?ISO-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>,
 Eugen Hristev <eugen.hristev@microchip.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Mauro,

On Tue, 2019-02-19 at 03:29 +0800, Mauro Carvalho Chehab wrote:
> drivers/media/platform/mtk-mdp/mtk_mdp_core.h      |  6 +++---

For drivers/media/platform/mtk-mdp/*
Reviewed-by: Houlong Wei <houlong.wei@mediatek.com>

Thanks a lot.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
