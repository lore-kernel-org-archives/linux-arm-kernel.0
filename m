From: davidb@codeaurora.org (David Brown)
Date: Mon, 29 Jul 2013 13:20:31 -0700
Subject: [PATCH v2 6/9] ARM: msm: Move mach/board.h contents to common.h
In-Reply-To: <1374699274-18388-7-git-send-email-sboyd@codeaurora.org>
References: <1374699274-18388-1-git-send-email-sboyd@codeaurora.org>
 <1374699274-18388-7-git-send-email-sboyd@codeaurora.org>
Message-ID: <20130729202031.GA20694@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 24, 2013 at 01:54:31PM -0700, Stephen Boyd wrote:
>The contents of mach/board.h are only used by files within
>mach-msm so there is no need to export this file outside of the
>mach-msm directory. Move the contents of the file to common.h to
>allow us to compile MSM in the multi-platform kernel.
>
>Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
>Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>---
> drivers/video/msm/msm_fb.c             |  1 -

It'd be nice to get a framebuffer Ack from this part.

original patch:
  https://patchwork.kernel.org/patch/2833029/

David

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
