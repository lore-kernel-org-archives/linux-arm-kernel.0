From: dhaval23031987@gmail.com (Dhaval Shah)
Date: Tue, 12 Dec 2017 11:39:05 +0530
Subject: [PATCH] media: v4l: xilinx: Use SPDX-License-Identifier
In-Reply-To: <1766939.Rkg4NBiJVp@avalon>
References: <20171208123537.18718-1-dhaval23031987@gmail.com>
 <1766939.Rkg4NBiJVp@avalon>
Message-ID: <CAOymtfLjf57-Utc+=99xCE3FBGGjySAO6JM3TE=crZ3MZUfzzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent Pinchart,

Thanks a lot for the review.

On Mon, Dec 11, 2017 at 7:17 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Dhaval,
>
> Thank you for the patch.
>
> On Friday, 8 December 2017 14:35:37 EET Dhaval Shah wrote:
> > SPDX-License-Identifier is used for the Xilinx Video IP and
> > related drivers.
> >
> > Signed-off-by: Dhaval Shah <dhaval23031987@gmail.com>
> > ---
> >  drivers/media/platform/xilinx/xilinx-dma.c  | 5 +----
> >  drivers/media/platform/xilinx/xilinx-dma.h  | 5 +----
> >  drivers/media/platform/xilinx/xilinx-tpg.c  | 5 +----
> >  drivers/media/platform/xilinx/xilinx-vip.c  | 5 +----
> >  drivers/media/platform/xilinx/xilinx-vip.h  | 5 +----
> >  drivers/media/platform/xilinx/xilinx-vipp.c | 5 +----
> >  drivers/media/platform/xilinx/xilinx-vipp.h | 5 +----
> >  drivers/media/platform/xilinx/xilinx-vtc.c  | 5 +----
> >  drivers/media/platform/xilinx/xilinx-vtc.h  | 5 +----
>
> How about addressing drivers/media/platform/xilinx/Makefile, drivers/media/
> platform/xilinx/Kconfig and include/dt-bindings/media/xilinx-vip.h as well ?
> If you're fine with that I can make the change when applying, there's no need
> to resubmit the patch.

Sorry, I forgot to update in those files. Thanks for that. I am fine
with what you said. Please do that change as you said.
>
> --
> Regards,
>
> Laurent Pinchart
>
