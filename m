From: robh+dt@kernel.org (Rob Herring)
Date: Tue, 28 Feb 2017 17:20:07 -0600
Subject: [PATCH 1/2] dts: arm64: add LS1043A DPAA support
In-Reply-To: <1485787387-12410-2-git-send-email-madalin.bucur@nxp.com>
References: <1485787387-12410-1-git-send-email-madalin.bucur@nxp.com>
 <1485787387-12410-2-git-send-email-madalin.bucur@nxp.com>
Message-ID: <CAL_Jsq+RnafS-sM=-NSUK1oXEEPrX4oU-x3qMjcFJpwKBGqPnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2017 at 8:43 AM, Madalin Bucur <madalin.bucur@nxp.com> wrote:
> Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
> ---

[...]

> diff --git a/arch/arm64/boot/dts/freescale/qoriq-bman1-portals.dtsi b/arch/arm64/boot/dts/freescale/qoriq-bman1-portals.dtsi
> new file mode 100644
> index 0000000..cfe6c58
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/qoriq-bman1-portals.dtsi
> @@ -0,0 +1,93 @@
> +/*
> + * QorIQ BMan Portal device tree stub for 9 portals
> + *
> + * Copyright 2011-2016 Freescale Semiconductor Inc.
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions are met:
> + *     * Redistributions of source code must retain the above copyright
> + *      notice, this list of conditions and the following disclaimer.
> + *     * Redistributions in binary form must reproduce the above copyright
> + *      notice, this list of conditions and the following disclaimer in the
> + *      documentation and/or other materials provided with the distribution.
> + *     * Neither the name of Freescale Semiconductor nor the
> + *      names of its contributors may be used to endorse or promote products
> + *      derived from this software without specific prior written permission.
> + *
> + *
> + * ALTERNATIVELY, this software may be distributed under the terms of the
> + * GNU General Public License ("GPL") as published by the Free Software
> + * Foundation, either version 2 of that License or (at your option) any
> + * later version.
> + *
> + * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
> + * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
> + * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
> + * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
> + * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
> + * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
> + * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
> + * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
> + * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + */

Use SPDX tags here:

SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
