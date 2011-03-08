From: davidb@codeaurora.org (David Brown)
Date: Tue, 08 Mar 2011 10:34:17 -0800
Subject: [PATCH v3 1/2] MAINTAINERS: Add drivers/platform/msm to MSM
	subsystem
In-Reply-To: <1299038465-11782-2-git-send-email-kheitke@codeaurora.org>
	(Kenneth Heitke's message of "Tue, 1 Mar 2011 21:01:04 -0700")
References: <1299038465-11782-1-git-send-email-kheitke@codeaurora.org>
	<1299038465-11782-2-git-send-email-kheitke@codeaurora.org>
Message-ID: <8yalj0pjwba.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 01 2011, Kenneth Heitke wrote:

> ---
>  MAINTAINERS |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 59869e4..696cb18 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -904,6 +904,7 @@ F:	drivers/mmc/host/msm_sdcc.c
>  F:	drivers/mmc/host/msm_sdcc.h
>  F:	drivers/tty/serial/msm_serial.h
>  F:	drivers/tty/serial/msm_serial.c
> +F:	drivers/platform/msm/
>  T:	git git://codeaurora.org/quic/kernel/davidb/linux-msm.git
>  S:	Maintained

This should be sent 'To' someone who will be able to bring this patch
into the tree.  Probably one of Andrew Morton or Greg KH should be made
the 'To' and this resent.  At a minimum, I would need one of them to
sign the patch off.

Thanks,
David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
