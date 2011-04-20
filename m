From: anish198519851985@gmail.com (anish singh)
Date: Wed, 20 Apr 2011 04:43:41 -0000
Subject: [PATCH v4] ARM: Use generic BUG() handler
In-Reply-To: <BANLkTikcY-xzjd0W77UfWWoO8ibjKNXQGg@mail.gmail.com>
References: <1302822031-6752-1-git-send-email-sjg@chromium.org>
	<4DA7A914.5020804@codeaurora.org>
	<BANLkTikcY-xzjd0W77UfWWoO8ibjKNXQGg@mail.gmail.com>
Message-ID: <BANLkTin_TpzdQS96SPKUNye6vb2b55Qc4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2011 at 8:10 AM, Simon Glass <sjg@chromium.org> wrote:

> On Thu, Apr 14, 2011 at 7:10 PM, Stephen Boyd <sboyd@codeaurora.org>
> wrote:
> > On 04/14/2011 04:00 PM, Simon Glass wrote:
> >> From: Simon Glass <sjg@google.com>
> >>
> >> ARM uses its own BUG() handler which makes its output slightly different
> >> from other archtectures.
>
>
> >> Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> > Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
>
> Thanks Stephen. Since there were no other comments I have submitted
> this to RMK's patch tracking system.
>

Will this be part of linux kernel as i am not aware of patch tracking
system? I want to back port this feature on my
board which has Linux 2.6.35.7 kernel version(android gingerbread).

>
> Regards,
> Simon
>
> >
> > --
> > Sent by an employee of the Qualcomm Innovation Center, Inc.
> > The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
> Forum.
> >
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110420/aef1f9ca/attachment-0001.html>
