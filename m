From: wuchengli@chromium.org (=?UTF-8?B?V3UtQ2hlbmcgTGkgKOadjuWLmeiqoCk=?=)
Date: Mon, 25 Jan 2016 12:46:02 +0800
Subject: [PATCH v4 0/2] new control V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME
In-Reply-To: <1453187230-97231-1-git-send-email-wuchengli@chromium.org>
References: <1453187230-97231-1-git-send-email-wuchengli@chromium.org>
Message-ID: <CAOMLVLh7EnMgVfzV7JQy6DSKSaanqHn5kNkTLVrbTCihjphzYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,
Can you look at the patch again? I've changed the name from
V4L2_CID_MPEG_VIDEO_FORCE_I_FRAME to
V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME. Thanks.

Wu-Cheng

On Tue, Jan 19, 2016 at 3:07 PM, Wu-Cheng Li <wuchengli@chromium.org> wrote:
> v4 changes:
> - Change the name to V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME.
> - Add commit message to s5p-mfc patch.
>
> Wu-Cheng Li (2):
>   v4l: add V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME.
>   s5p-mfc: add the support of V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME.
>
>  Documentation/DocBook/media/v4l/controls.xml |  8 ++++++++
>  drivers/media/platform/s5p-mfc/s5p_mfc_enc.c | 12 ++++++++++++
>  drivers/media/v4l2-core/v4l2-ctrls.c         |  2 ++
>  include/uapi/linux/v4l2-controls.h           |  1 +
>  4 files changed, 23 insertions(+)
>
> --
> 2.6.0.rc2.230.g3dd15c0
>
