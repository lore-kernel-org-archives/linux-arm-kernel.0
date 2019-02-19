Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9ECC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:58:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA1D62147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ga7x35eS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA1D62147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tHIHcuh2NDo4cMDz5j7lEZm0PsPtBxg6xfeM0fMnQzo=; b=Ga7x35eSF0M5io
	zbfkaeH2/bTAfk7Ib4toEI1obaDlrjGg94Aanv1w8gGYgqoYMDftL75OgVhJAmzcES6+zFc/HA9RU
	xvojQoarAiHU37EFQTRk7HIL26T+d/mZzJYUoE/9N8nCfZRB5wZmucHluaqvuVNR7s3lyYi8F5L8H
	ZBK48nypAHUO1LaBgQ4YmW6KLc3fSJqwpR2WP6Q1NyWMfV+BGyibT3lJIfuKpsYOXYwKFqqE8ufMP
	gwAd1GiddJ3hCBVoLAbL+/PXnE6AYs7QDphGBmQVS5ZnfeWTZm3vlBHcwDYKbcBt1VXrfO6u1M4fv
	HTDWRy9JyRaOBqgALR+w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw8j4-0007PU-Pp; Tue, 19 Feb 2019 16:58:34 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw8j0-0007EF-Nu
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 16:58:32 +0000
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <pza@pengutronix.de>)
 id 1gw8iD-00081u-7v; Tue, 19 Feb 2019 17:57:41 +0100
Received: from pza by ptx.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <pza@pengutronix.de>)
 id 1gw8i2-0005zK-HO; Tue, 19 Feb 2019 17:57:30 +0100
Date: Tue, 19 Feb 2019 17:57:30 +0100
From: Philipp Zabel <pza@pengutronix.de>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH 06/14] media: platform: fix several typos
Message-ID: <20190219165730.krayjve6ychvlxqn@pengutronix.de>
References: <f235ba60b2b7e5fba09d3c6b0d5dbbd8a86ea9b9.1550518128.git.mchehab+samsung@kernel.org>
 <362e90167292e8d0c03a8d0753cc26b89549d854.1550518128.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <362e90167292e8d0c03a8d0753cc26b89549d854.1550518128.git.mchehab+samsung@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-IRC: #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 17:56:09 up 8 days, 1:21, 58 users, load average: 0.37, 0.25, 0.19
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: pza@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_085830_939644_5D1A53E9 
X-CRM114-Status: GOOD (  14.80  )
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
Cc: Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Minghsiu Tsai <minghsiu.tsai@mediatek.com>, Heiko Stuebner <heiko@sntech.de>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Patrice Chotard <patrice.chotard@st.com>, Andrzej Hajda <a.hajda@samsung.com>,
 "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Michal Simek <michal.simek@xilinx.com>,
 Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
 linux-samsung-soc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Chen-Yu Tsai <wens@csie.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 linux-stm32@st-md-mailman.stormreply.com, linux-rockchip@lists.infradead.org,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 Kukjin Kim <kgene@kernel.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Kamil Debski <kamil@wypas.org>, Alexandre Torgue <alexandre.torgue@st.com>,
 linux-arm-msm@vger.kernel.org, Houlong Wei <houlong.wei@mediatek.com>,
 Mauro Carvalho Chehab <mchehab@infradead.org>, Benoit Parrot <bparrot@ti.com>,
 Jeongtae Park <jtp.park@samsung.com>, linux-mediatek@lists.infradead.org,
 Jacek Anaszewski <jacek.anaszewski@gmail.com>,
 Yong Deng <yong.deng@magewell.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Hugues Fruchet <hugues.fruchet@st.com>, Tiffany Lin <tiffany.lin@mediatek.com>,
 linux-arm-kernel@lists.infradead.org, Hyun Kwon <hyun.kwon@xilinx.com>,
 Jacob chen <jacob2.chen@rock-chips.com>, linux-renesas-soc@vger.kernel.org,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Jean-Christophe Trotin <jean-christophe.trotin@st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>,
 Eugen Hristev <eugen.hristev@microchip.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 18, 2019 at 02:29:00PM -0500, Mauro Carvalho Chehab wrote:
> Use codespell to fix lots of typos over frontends.
> 
> Manually verified to avoid false-positives.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
[...]
> diff --git a/drivers/media/platform/coda/coda-jpeg.c b/drivers/media/platform/coda/coda-jpeg.c
> index 9f899a6cefed..39a2351c1e48 100644
> --- a/drivers/media/platform/coda/coda-jpeg.c
> +++ b/drivers/media/platform/coda/coda-jpeg.c
> @@ -103,7 +103,7 @@ static const unsigned char chroma_ac_value[162 + 2] = {
>  
>  /*
>   * Quantization tables for luminance and chrominance components in
> - * zig-zag scan order from the Freescale i.MX VPU libaries
> + * zig-zag scan order from the Freescale i.MX VPU libraries
>   */
>  
>  static unsigned char luma_q[64] = {

Thank you, for coda
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
