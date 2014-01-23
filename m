From: prabhakar.csengg@gmail.com (Prabhakar Lad)
Date: Thu, 23 Jan 2014 11:12:54 +0530
Subject: [PATCH] [media] s5p-mfc: Add Horizontal and Vertical search range
 for Video Macro Blocks
In-Reply-To: <DA6097ED98694425932A6AF93513371A@sisodomain.com>
References: <1388400186-22045-1-git-send-email-amit.grover@samsung.com>
 <DA6097ED98694425932A6AF93513371A@sisodomain.com>
Message-ID: <CA+V-a8uQAeY1zM+YVWi7QXPSPwAEhD=Gds-15sk+e9VbaNN98g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Swaminathan,

On Thu, Jan 23, 2014 at 10:49 AM, swaminathan <swaminath.p@samsung.com> wrote:
> Hi All,
> Is there any review Comments for the patch "[PATCH] [media] s5p-mfc: Add
> Horizontal and Vertical search range for Video Macro Blocks"
> posted on 30-Dec-2013 ?
>
>
Just a side note, please don?t top post and always reply as plain text.

[Snip]

> Subject: [PATCH] [media] s5p-mfc: Add Horizontal and Vertical search range
> for Video Macro Blocks
>
>
>> This patch adds Controls to set Horizontal and Vertical search range
>> for Motion Estimation block for Samsung MFC video Encoders.
>>
>> Signed-off-by: Swami Nathan <swaminath.p@samsung.com>
>> Signed-off-by: Amit Grover <amit.grover@samsung.com>
>> ---
>> Documentation/DocBook/media/v4l/controls.xml    |   14 +++++++++++++
>> drivers/media/platform/s5p-mfc/s5p_mfc_common.h |    2 ++
>> drivers/media/platform/s5p-mfc/s5p_mfc_enc.c    |   24
>> +++++++++++++++++++++++
>> drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c |    8 ++------
>> drivers/media/v4l2-core/v4l2-ctrls.c            |   14 +++++++++++++
>> include/uapi/linux/v4l2-controls.h              |    2 ++
>> 6 files changed, 58 insertions(+), 6 deletions(-)
>>
This patch from the outset looks OK,  but you need to split up
into two, first adding a v4l control and second one using it up in the driver.

Regards,
--Prabhakar Lad
