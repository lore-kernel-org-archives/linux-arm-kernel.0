From: robherring2@gmail.com (Rob Herring)
Date: Sat, 26 Jul 2014 16:20:03 -0500
Subject: [RESEND][PATCHv2 0/3] Fix for buggy u-boot memory banks
In-Reply-To: <1405443816-29917-1-git-send-email-lauraa@codeaurora.org>
References: <1405443816-29917-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <CAL_JsqJv2_UHxHGFF=nFKQRiEwfFtH_7PhMPS=W=APyzc-yiTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 15, 2014 at 12:03 PM, Laura Abbott <lauraa@codeaurora.org> wrote:
> Hi,
>
> This is a resend of the series to fix the uboot bug exposed by the removal
> of meminfo. I haven't gotten any acks though.

Is the bug with ATAGs that get converted to DT in the decompressor or
u-boot puts the wrong info in DT directly?

Rob

>
> Please help with review/acks. Grant/Rob, I'd still like this to go through
> the devicetree tree if possible.
>
> Thanks,
> Laura
>
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> hosted by The Linux Foundation
>
