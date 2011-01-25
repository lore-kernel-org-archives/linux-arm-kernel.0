From: davidb@codeaurora.org (David Brown)
Date: Mon, 24 Jan 2011 17:05:22 -0800
Subject: [PATCH] msm: serial: Add MSM8960 serial support
In-Reply-To: <1295663921-32723-1-git-send-email-stepanm@codeaurora.org>
	(Stepan Moskovchenko's message of "Fri, 21 Jan 2011 18:38:41 -0800")
References: <1295663921-32723-1-git-send-email-stepanm@codeaurora.org>
Message-ID: <8yar5c1hjxp.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 21 2011, Stepan Moskovchenko wrote:

> diff --git a/arch/arm/mach-msm/devices-msm8960.c b/arch/arm/mach-msm/devices-msm8960.c
> new file mode 100644
> index 0000000..821e6d1
> --- /dev/null
> +++ b/arch/arm/mach-msm/devices-msm8960.c
> @@ -0,0 +1,83 @@
> +/*
> + * Copyright (C) 2008 Google, Inc.
> + * Copyright (c) 2008-2011, Code Aurora Forum. All rights reserved.

What is the general consenus on this kind of copyright.  Stepan started
with a file with a Google copyright on it, but has largely rewritten the
file to support the new board.  Should we be keeping the copyright from
the file?

Thanks,
David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
