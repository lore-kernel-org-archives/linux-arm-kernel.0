From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Mon, 25 Jan 2016 09:57:53 +0100
Subject: [PATCH v4 0/2] new control V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME
In-Reply-To: <CAOMLVLh7EnMgVfzV7JQy6DSKSaanqHn5kNkTLVrbTCihjphzYA@mail.gmail.com>
References: <1453187230-97231-1-git-send-email-wuchengli@chromium.org>
 <CAOMLVLh7EnMgVfzV7JQy6DSKSaanqHn5kNkTLVrbTCihjphzYA@mail.gmail.com>
Message-ID: <56A5E391.8050505@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/25/2016 05:46 AM, Wu-Cheng Li (???) wrote:
> Hi Hans,
> Can you look at the patch again? I've changed the name from
> V4L2_CID_MPEG_VIDEO_FORCE_I_FRAME to
> V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME. Thanks.

Looks good to me. I'm planning to make a pull request for this once v4.5-rc1 is
merged into our media_tree repo.

Regards,

	Hans

> 
> Wu-Cheng
> 
> On Tue, Jan 19, 2016 at 3:07 PM, Wu-Cheng Li <wuchengli@chromium.org> wrote:
>> v4 changes:
>> - Change the name to V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME.
>> - Add commit message to s5p-mfc patch.
>>
>> Wu-Cheng Li (2):
>>   v4l: add V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME.
>>   s5p-mfc: add the support of V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME.
>>
>>  Documentation/DocBook/media/v4l/controls.xml |  8 ++++++++
>>  drivers/media/platform/s5p-mfc/s5p_mfc_enc.c | 12 ++++++++++++
>>  drivers/media/v4l2-core/v4l2-ctrls.c         |  2 ++
>>  include/uapi/linux/v4l2-controls.h           |  1 +
>>  4 files changed, 23 insertions(+)
>>
>> --
>> 2.6.0.rc2.230.g3dd15c0
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-media" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
