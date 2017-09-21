From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 21 Sep 2017 15:29:53 +0100
Subject: [v5 01/12] soc/fsl/qbman: Add common routine for QBMan private
 allocations
In-Reply-To: <1505767187-4596-2-git-send-email-roy.pledge@nxp.com>
References: <1505767187-4596-1-git-send-email-roy.pledge@nxp.com>
 <1505767187-4596-2-git-send-email-roy.pledge@nxp.com>
Message-ID: <20170921142953.plg23446m546iloa@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 18, 2017 at 04:39:36PM -0400, Roy Pledge wrote:
> --- /dev/null
> +++ b/drivers/soc/fsl/qbman/dpaa_sys.c
> @@ -0,0 +1,78 @@
> +/* Copyright 2017 NXP Semiconductor, Inc.
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions are met:
> + *     * Redistributions of source code must retain the above copyright
> + *	 notice, this list of conditions and the following disclaimer.
> + *     * Redistributions in binary form must reproduce the above copyright
> + *	 notice, this list of conditions and the following disclaimer in the
> + *	 documentation and/or other materials provided with the distribution.
> + *     * Neither the name of NXP Semiconductor nor the
> + *	 names of its contributors may be used to endorse or promote products
> + *	 derived from this software without specific prior written permission.
> + *
> + * ALTERNATIVELY, this software may be distributed under the terms of the
> + * GNU General Public License ("GPL") as published by the Free Software
> + * Foundation, either version 2 of that License or (at your option) any
> + * later version.
> + *
> + * THIS SOFTWARE IS PROVIDED BY NXP Semiconductor ``AS IS'' AND ANY
> + * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
> + * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
> + * DISCLAIMED. IN NO EVENT SHALL NXP Semiconductor BE LIABLE FOR ANY
> + * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
> + * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
> + * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
> + * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
> + * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + */

Pretty verbose header, I guess GPLv2 would do but IANAL.

Anyway:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
