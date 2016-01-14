From: nicolas.dufresne@collabora.com (Nicolas Dufresne)
Date: Thu, 14 Jan 2016 10:05:47 -0500
Subject: [PATCH v3 0/2] new control V4L2_CID_MPEG_VIDEO_FORCE_I_FRAME
In-Reply-To: <1452783007-80883-1-git-send-email-wuchengli@chromium.org>
References: <1452783007-80883-1-git-send-email-wuchengli@chromium.org>
Message-ID: <1452783947.10009.20.camel@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le jeudi 14 janvier 2016 ? 22:50 +0800, Wu-Cheng Li a ?crit?:
> v3 addressed Hans' comment to remove the name of the control in s5p-
> mfc.
> 
> Wu-Cheng Li (2):
> ? v4l: add V4L2_CID_MPEG_VIDEO_FORCE_I_FRAME.

Hans suggested to name it V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME.

regards,
Nicolas

> ? s5p-mfc: add the support of V4L2_CID_MPEG_VIDEO_FORCE_I_FRAME.
> 
> ?Documentation/DocBook/media/v4l/controls.xml |??8 ++++++++
> ?drivers/media/platform/s5p-mfc/s5p_mfc_enc.c | 12 ++++++++++++
> ?drivers/media/v4l2-core/v4l2-ctrls.c?????????|??2 ++
> ?include/uapi/linux/v4l2-controls.h???????????|??1 +
> ?4 files changed, 23 insertions(+)
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160114/4a6cbbb3/attachment.sig>
