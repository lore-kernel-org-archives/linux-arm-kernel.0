From: davidb@codeaurora.org (David Brown)
Date: Wed, 6 Oct 2010 08:50:48 -0700
Subject: [PATCH 03/20 v2] msm: initial irq definitions for MSM8X60
In-Reply-To: <1286350979-19328-4-git-send-email-johlstei@codeaurora.org>
References: <1286350979-19328-1-git-send-email-johlstei@codeaurora.org>
	<1286350979-19328-4-git-send-email-johlstei@codeaurora.org>
Message-ID: <20101006155048.GA25662@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 06, 2010 at 12:42:42AM -0700, Jeff Ohlstein wrote:
> --- /dev/null
> +++ b/arch/arm/mach-msm/include/mach/irqs-8x60.h
> @@ -0,0 +1,43 @@
> +/* Copyright (c) 2010 Code Aurora Forum. All rights reserved.
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions are met:
> + *     * Redistributions of source code must retain the above copyright
> + *       notice, this list of conditions and the following disclaimer.
> + *     * Redistributions in binary form must reproduce the above copyright
> + *       notice, this list of conditions and the following disclaimer in the
> + *       documentation and/or other materials provided with the distribution.
> + *     * Neither the name of Code Aurora nor
> + *       the names of its contributors may be used to endorse or promote
> + *       products derived from this software without specific prior written
> + *       permission.

We missed another of these.  Please be sure to carefully check that
all of the files have the GPLv2 license text, not this license.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
