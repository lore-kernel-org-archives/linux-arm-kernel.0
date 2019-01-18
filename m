Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FFDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:48:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EA1C20657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c4+aRXB3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EA1C20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VkkoT4SzjepCM5KkN0+FZloCnBZX7kUlGsFZV4c2PLY=; b=c4+aRXB3MdZJUM
	fZdsoOdDsCCuwmXdiW+2d/R/AZBgrwP7bkuLkx2ErI4JjBHtLxJzik0NQPKreLEUoJE1HUfE35Uq/
	3uk8xBB4w7oMm8noS/x9qjw4RekAjpwv8LiycBZKBg7Fnn0Dyv++8bJ2f9bO8ZSF8WN/heoba68lG
	ua8EJoR+mqvTIMTUwujV8KVvvyQXTizyhAmEtJLDpNQWx8YdZST3C2eGq0Pm2Hrw1dchZZCK/bm71
	dzCxH8QZMb8grfMVKMN4ynkAvlbgXxVFJvsXdFmkm+h81ftFZJtyKkAqPwkWmUc3NVicy0ehZ4i0C
	QbyxlojdjnxzQhku6HQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkVRv-000403-EW; Fri, 18 Jan 2019 14:48:47 +0000
Received: from mga02.intel.com ([134.134.136.20])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkVNm-0007E7-HM
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 14:44:40 +0000
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Jan 2019 06:44:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,491,1539673200"; d="scan'208";a="115697668"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
 by fmsmga007.fm.intel.com with SMTP; 18 Jan 2019 06:44:25 -0800
Received: by stinkbox (sSMTP sendmail emulation);
 Fri, 18 Jan 2019 16:44:24 +0200
Date: Fri, 18 Jan 2019 16:44:24 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Andrzej Hajda <a.hajda@samsung.com>
Subject: Re: [PATCH 1/6] include/drm: color_mgmt: Add enum labels
Message-ID: <20190118144424.GL20097@intel.com>
References: <1544789421-5265-1-git-send-email-c.manszewski@samsung.com>
 <CGME20181214121032eucas1p24af580721ebd6f86a4f9ddf701957ab6@eucas1p2.samsung.com>
 <1544789421-5265-2-git-send-email-c.manszewski@samsung.com>
 <20190117194722.GJ20097@intel.com>
 <b9cfbae1-b24e-96bf-f3b0-ff6d25cd16bb@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b9cfbae1-b24e-96bf-f3b0-ff6d25cd16bb@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_064430_765562_4B7A65E2 
X-CRM114-Status: GOOD (  22.31  )
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
Cc: linux-samsung-soc@vger.kernel.org,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Christoph Manszewski <c.manszewski@samsung.com>,
 David Airlie <airlied@linux.ie>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>,
 'Hans Verkuil' <hans.verkuil@cisco.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 18, 2019 at 03:34:18PM +0100, Andrzej Hajda wrote:
> +CC: Hans
> =

> On 17.01.2019 20:47, Ville Syrj=E4l=E4 wrote:
> > On Fri, Dec 14, 2018 at 01:10:16PM +0100, Christoph Manszewski wrote:
> >> Range setting makes sense for YCbCr and RGB buffers. Current
> >> drm_color_range enum labels suggest use with YCbCr buffers.
> >> Create enum labels without colorspace specification.
> >>
> >> Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
> >> ---
> >>  include/drm/drm_color_mgmt.h | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/include/drm/drm_color_mgmt.h b/include/drm/drm_color_mgmt=
.h
> >> index 90ef9996d9a4..52f6d5221a0d 100644
> >> --- a/include/drm/drm_color_mgmt.h
> >> +++ b/include/drm/drm_color_mgmt.h
> >> @@ -62,6 +62,8 @@ enum drm_color_range {
> >>  	DRM_COLOR_YCBCR_LIMITED_RANGE,
> >>  	DRM_COLOR_YCBCR_FULL_RANGE,
> >>  	DRM_COLOR_RANGE_MAX,
> >> +	DRM_COLOR_LIMITED_RANGE =3D DRM_COLOR_YCBCR_LIMITED_RANGE,
> >> +	DRM_COLOR_FULL_RANGE =3D DRM_COLOR_YCBCR_FULL_RANGE,
> > These enum values don't mean anything really. The strings are what
> > matter for the uapi.
> >
> > The default for YCbCr needs to be limited range, the default for RGB
> > needs to be full range. So I think this would really require a separate
> > prop for each.
> >
> > But is there an actual usecase for this stuff?
> =

> =

> Yes, for example HDMI path (Display Controller and HDMI encoder) in
> Exynos5433 works on RGB buffers and do not perform any conversion if the
> output is also RGB, on the other side CEA861 specs says that in case of
> CEA modes output RGB should be in limited range, in case of non CEA
> modes it should be full range.
> =

> The idea was to allow userspace to check (atomic_check) which ranges are
> acceptable in given mode and to set desired one if possible.
> =

> Any better solution is welcome?

i915 has the "Broadcast RGB" property for the CEA-861 stuff.
You don't have a way to implement that?

-- =

Ville Syrj=E4l=E4
Intel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
