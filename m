Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E9CC4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:29:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59540217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h1KR9bMx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59540217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/QhNtBfwv7kjAQpK3tuxc35eb8XzmEQzvgECTFmKufE=; b=h1KR9bMxWUw2dc
	u965N6R+DHAkmwf8f0Nt4pezxnyYH8Cg649Aa5TFqjExPfSlQNLi8cxSBZnOCikg836Oh/ncC9xv6
	jCoQ+PCiMCD6z6Je6RurKPlXBlgo0xjDWTp3HcAhU6Vlq5XhmMXue8bDIXmZca8CKzJHo63noqFDT
	16Ir+36Zk5yud4rStN+gf9CuaFUsBciHAl47Fw/SJkc0a1BR1wZ+9oUXeT0dMFiT0Ye3eDGLXkrbQ
	6tTz+4obNHdp6qHnKPA8i6RyYYb148X2hNJrBZpPI8RS0eAfEhvUSYXYAYYljp1jBuc/nvwozQlxS
	N+0LQZTiNlVKRDksYPuw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvobN-0002Wq-7g; Mon, 18 Feb 2019 19:29:17 +0000
Received: from 177.96.194.24.dynamic.adsl.gvt.net.br ([177.96.194.24]
 helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvobJ-0002Us-9v; Mon, 18 Feb 2019 19:29:13 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.91)
 (envelope-from <mchehab@bombadil.infradead.org>)
 id 1gvobG-0006gV-Fi; Mon, 18 Feb 2019 14:29:10 -0500
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: 
Subject: [PATCH 12/14] media: include: fix several typos
Date: Mon, 18 Feb 2019 14:29:06 -0500
Message-Id: <8ad3211c5c6c6835997237af02df71eeb2c78c17.1550518128.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <f235ba60b2b7e5fba09d3c6b0d5dbbd8a86ea9b9.1550518128.git.mchehab+samsung@kernel.org>
References: <f235ba60b2b7e5fba09d3c6b0d5dbbd8a86ea9b9.1550518128.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
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
Cc: linux-samsung-soc@vger.kernel.org, Pawel Osciak <pawel@osciak.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Mauro Carvalho Chehab <mchehab@infradead.org>,
 Hans Verkuil <hverkuil@xs4all.nl>, "Lad,
 Prabhakar" <prabhakar.csengg@gmail.com>, Kukjin Kim <kgene@kernel.org>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 linux-arm-kernel@lists.infradead.org,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Use codespell to fix lots of typos over frontends.

Manually verified to avoid false-positives.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 include/linux/platform_data/media/si4713.h | 4 ++--
 include/media/davinci/dm355_ccdc.h         | 4 ++--
 include/media/davinci/dm644x_ccdc.h        | 2 +-
 include/media/drv-intf/exynos-fimc.h       | 2 +-
 include/media/drv-intf/saa7146.h           | 2 +-
 include/media/drv-intf/saa7146_vv.h        | 4 ++--
 include/media/dvb_frontend.h               | 8 ++++----
 include/media/rc-map.h                     | 4 ++--
 include/media/v4l2-ctrls.h                 | 2 +-
 include/media/v4l2-fwnode.h                | 4 ++--
 include/media/v4l2-subdev.h                | 2 +-
 include/media/videobuf-core.h              | 2 +-
 include/media/videobuf2-core.h             | 2 +-
 13 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/include/linux/platform_data/media/si4713.h b/include/linux/platform_data/media/si4713.h
index 932668ad54f7..13b3eb7a9059 100644
--- a/include/linux/platform_data/media/si4713.h
+++ b/include/linux/platform_data/media/si4713.h
@@ -31,7 +31,7 @@ struct si4713_platform_data {
  */
 struct si4713_rnl {
 	__u32 index;		/* modulator index */
-	__u32 frequency;	/* frequency to peform rnl measurement */
+	__u32 frequency;	/* frequency to perform rnl measurement */
 	__s32 rnl;		/* result of measurement in dBuV */
 	__u32 reserved[4];	/* drivers and apps must init this to 0 */
 };
@@ -40,7 +40,7 @@ struct si4713_rnl {
  * This is the ioctl number to query for rnl. Users must pass a
  * struct si4713_rnl pointer specifying desired frequency in 'frequency' field
  * following driver capabilities (i.e V4L2_TUNER_CAP_LOW).
- * Driver must return measured value in the same struture, filling 'rnl' field.
+ * Driver must return measured value in the same structure, filling 'rnl' field.
  */
 #define SI4713_IOC_MEASURE_RNL	_IOWR('V', BASE_VIDIOC_PRIVATE + 0, \
 						struct si4713_rnl)
diff --git a/include/media/davinci/dm355_ccdc.h b/include/media/davinci/dm355_ccdc.h
index e6bc72f6b60f..1cba42d805fa 100644
--- a/include/media/davinci/dm355_ccdc.h
+++ b/include/media/davinci/dm355_ccdc.h
@@ -228,7 +228,7 @@ struct ccdc_config_params_raw {
 	/* Threshold of median filter */
 	int med_filt_thres;
 	/*
-	 * horz and vertical data offset. Appliable for defect correction
+	 * horz and vertical data offset. Applicable for defect correction
 	 * and lsc
 	 */
 	struct ccdc_data_offset data_offset;
@@ -238,7 +238,7 @@ struct ccdc_config_params_raw {
 	struct ccdc_black_clamp blk_clamp;
 	/* Structure for Black Compensation */
 	struct ccdc_black_compensation blk_comp;
-	/* struture for vertical Defect Correction Module Configuration */
+	/* structure for vertical Defect Correction Module Configuration */
 	struct ccdc_vertical_dft vertical_dft;
 	/* structure for color space converter Module Configuration */
 	struct ccdc_csc csc;
diff --git a/include/media/davinci/dm644x_ccdc.h b/include/media/davinci/dm644x_ccdc.h
index 6ea2ce241851..694fc8f6081f 100644
--- a/include/media/davinci/dm644x_ccdc.h
+++ b/include/media/davinci/dm644x_ccdc.h
@@ -152,7 +152,7 @@ struct ccdc_params_raw {
 	 * order in memory(bottom to top)
 	 */
 	unsigned char image_invert_enable;
-	/* configurable paramaters */
+	/* configurable parameters */
 	struct ccdc_config_params_raw config_params;
 };
 
diff --git a/include/media/drv-intf/exynos-fimc.h b/include/media/drv-intf/exynos-fimc.h
index f9c64338841f..54c214737142 100644
--- a/include/media/drv-intf/exynos-fimc.h
+++ b/include/media/drv-intf/exynos-fimc.h
@@ -81,7 +81,7 @@ struct fimc_source_info {
  * v4l2_device notification id. This is only for internal use in the kernel.
  * Sensor subdevs should issue S5P_FIMC_TX_END_NOTIFY notification in single
  * frame capture mode when there is only one VSYNC pulse issued by the sensor
- * at begining of the frame transmission.
+ * at beginning of the frame transmission.
  */
 #define S5P_FIMC_TX_END_NOTIFY _IO('e', 0)
 
diff --git a/include/media/drv-intf/saa7146.h b/include/media/drv-intf/saa7146.h
index a7bf2c4a2e4d..71ce63c99cb4 100644
--- a/include/media/drv-intf/saa7146.h
+++ b/include/media/drv-intf/saa7146.h
@@ -139,7 +139,7 @@ struct saa7146_dev
 	void				*ext_priv;	/* pointer for extension private use (most likely some private data) */
 	struct saa7146_ext_vv		*ext_vv_data;
 
-	/* per device video/vbi informations (if available) */
+	/* per device video/vbi information (if available) */
 	struct saa7146_vv	*vv_data;
 	void (*vv_callback)(struct saa7146_dev *dev, unsigned long status);
 
diff --git a/include/media/drv-intf/saa7146_vv.h b/include/media/drv-intf/saa7146_vv.h
index 6f80fb7f31a5..b34d86bb0664 100644
--- a/include/media/drv-intf/saa7146_vv.h
+++ b/include/media/drv-intf/saa7146_vv.h
@@ -151,7 +151,7 @@ struct saa7146_vv
 
 struct saa7146_ext_vv
 {
-	/* informations about the video capabilities of the device */
+	/* information about the video capabilities of the device */
 	int	inputs;
 	int	audios;
 	u32	capabilities;
@@ -241,7 +241,7 @@ void saa7146_res_free(struct saa7146_fh *fh, unsigned int bits);
 #define SAA7146_CLIPPING_MASK		0x6
 #define SAA7146_CLIPPING_MASK_INVERTED	0x7
 
-/* output formats: each entry holds four informations */
+/* output formats: each entry holds four information */
 #define RGB08_COMPOSED	0x0217 /* composed is used in the sense of "not-planar" */
 /* this means: planar?=0, yuv2rgb-conversation-mode=2, dither=yes(=1), format-mode = 7 */
 #define RGB15_COMPOSED	0x0213
diff --git a/include/media/dvb_frontend.h b/include/media/dvb_frontend.h
index 6f7a85ab3541..f05cd7b94a2c 100644
--- a/include/media/dvb_frontend.h
+++ b/include/media/dvb_frontend.h
@@ -160,7 +160,7 @@ enum dvbfe_algo {
  *	The frontend search for a signal failed
  *
  * @DVBFE_ALGO_SEARCH_INVALID:
- *	The frontend search algorith was probably supplied with invalid
+ *	The frontend search algorithm was probably supplied with invalid
  *	parameters and the search is an invalid one
  *
  * @DVBFE_ALGO_SEARCH_ERROR:
@@ -204,7 +204,7 @@ enum dvbfe_search {
  * @set_config:		callback function used to send some tuner-specific
  *			parameters.
  * @get_frequency:	get the actual tuned frequency
- * @get_bandwidth:	get the bandwitdh used by the low pass filters
+ * @get_bandwidth:	get the bandwidth used by the low pass filters
  * @get_if_frequency:	get the Intermediate Frequency, in Hz. For baseband,
  *			should return 0.
  * @get_status:		returns the frontend lock status
@@ -232,7 +232,7 @@ struct dvb_tuner_ops {
 	int (*suspend)(struct dvb_frontend *fe);
 	int (*resume)(struct dvb_frontend *fe);
 
-	/* This is the recomended way to set the tuner */
+	/* This is the recommended way to set the tuner */
 	int (*set_params)(struct dvb_frontend *fe);
 	int (*set_analog_params)(struct dvb_frontend *fe, struct analog_parameters *p);
 
@@ -358,7 +358,7 @@ struct dvb_frontend_internal_info {
  * @release:		callback function called when frontend is ready to be
  *			freed.
  *			drivers should free any allocated memory.
- * @release_sec:	callback function requesting that the Satelite Equipment
+ * @release_sec:	callback function requesting that the Satellite Equipment
  *			Control (SEC) driver to release and free any memory
  *			allocated by the driver.
  * @init:		callback function used to initialize the tuner device.
diff --git a/include/media/rc-map.h b/include/media/rc-map.h
index d621acadfbf3..d2e689fd6b3e 100644
--- a/include/media/rc-map.h
+++ b/include/media/rc-map.h
@@ -136,14 +136,14 @@ struct rc_map_list {
 /* Routines from rc-map.c */
 
 /**
- * rc_map_register() - Registers a Remote Controler scancode map
+ * rc_map_register() - Registers a Remote Controller scancode map
  *
  * @map:	pointer to struct rc_map_list
  */
 int rc_map_register(struct rc_map_list *map);
 
 /**
- * rc_map_unregister() - Unregisters a Remote Controler scancode map
+ * rc_map_unregister() - Unregisters a Remote Controller scancode map
  *
  * @map:	pointer to struct rc_map_list
  */
diff --git a/include/media/v4l2-ctrls.h b/include/media/v4l2-ctrls.h
index d63cf227b0ab..e5cae37ced2d 100644
--- a/include/media/v4l2-ctrls.h
+++ b/include/media/v4l2-ctrls.h
@@ -648,7 +648,7 @@ struct v4l2_ctrl *v4l2_ctrl_new_std_menu_items(struct v4l2_ctrl_handler *hdl,
  * @def:	The control's default value.
  * @qmenu_int:	The control's menu entries.
  *
- * Same as v4l2_ctrl_new_std_menu(), but @mask is set to 0 and it additionaly
+ * Same as v4l2_ctrl_new_std_menu(), but @mask is set to 0 and it additionally
  * takes as an argument an array of integers determining the menu items.
  *
  * If @id refers to a non-integer-menu control, then this function will
diff --git a/include/media/v4l2-fwnode.h b/include/media/v4l2-fwnode.h
index 6d9d9f1839ac..6c07825e18b9 100644
--- a/include/media/v4l2-fwnode.h
+++ b/include/media/v4l2-fwnode.h
@@ -143,7 +143,7 @@ struct v4l2_fwnode_link {
  * @vep.bus_type to V4L2_MBUS_UNKNOWN. The caller may not provide a default
  * configuration in this case as the defaults are specific to a given bus type.
  * This functionality is deprecated and should not be used in new drivers and it
- * is only supported for CSI-2 D-PHY, parallel and Bt.656 busses.
+ * is only supported for CSI-2 D-PHY, parallel and Bt.656 buses.
  *
  * The function does not change the V4L2 fwnode endpoint state if it fails.
  *
@@ -186,7 +186,7 @@ void v4l2_fwnode_endpoint_free(struct v4l2_fwnode_endpoint *vep);
  * @vep.bus_type to V4L2_MBUS_UNKNOWN. The caller may not provide a default
  * configuration in this case as the defaults are specific to a given bus type.
  * This functionality is deprecated and should not be used in new drivers and it
- * is only supported for CSI-2 D-PHY, parallel and Bt.656 busses.
+ * is only supported for CSI-2 D-PHY, parallel and Bt.656 buses.
  *
  * The function does not change the V4L2 fwnode endpoint state if it fails.
  *
diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
index 34da094a3f40..349e1c18cf48 100644
--- a/include/media/v4l2-subdev.h
+++ b/include/media/v4l2-subdev.h
@@ -70,7 +70,7 @@ struct v4l2_decode_vbi_line {
  * device. These devices are usually audio/video muxers/encoders/decoders or
  * sensors and webcam controllers.
  *
- * Usually these devices are controlled through an i2c bus, but other busses
+ * Usually these devices are controlled through an i2c bus, but other buses
  * may also be used.
  *
  * The v4l2_subdev struct provides a way of accessing these devices in a
diff --git a/include/media/videobuf-core.h b/include/media/videobuf-core.h
index 5684dc6f0d0d..2c4db97cd96f 100644
--- a/include/media/videobuf-core.h
+++ b/include/media/videobuf-core.h
@@ -43,7 +43,7 @@ struct videobuf_queue;
  * (which v4l2 uses).
  *
  * If there is a valid mapping for a buffer, buffer->baddr/bsize holds
- * userspace address + size which can be feeded into the
+ * userspace address + size which can be fed into the
  * videobuf_dma_init_user function listed above.
  *
  */
diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
index 06142c1469cc..fb0ea7a06cc9 100644
--- a/include/media/videobuf2-core.h
+++ b/include/media/videobuf2-core.h
@@ -396,7 +396,7 @@ struct vb2_buffer {
  * @buf_queue:		passes buffer vb to the driver; driver may start
  *			hardware operation on this buffer; driver should give
  *			the buffer back by calling vb2_buffer_done() function;
- *			it is allways called after calling VIDIOC_STREAMON()
+ *			it is always called after calling VIDIOC_STREAMON()
  *			ioctl; might be called before @start_streaming callback
  *			if user pre-queued buffers before calling
  *			VIDIOC_STREAMON().
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
