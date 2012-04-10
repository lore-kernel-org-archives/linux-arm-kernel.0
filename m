From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 10 Apr 2012 14:22:34 -0400 (EDT)
Subject: [PATCH 2/2] ARM: DT: do not add a zero-sized memory property
In-Reply-To: <1334080601-14339-2-git-send-email-marc.zyngier@arm.com>
References: <1334080601-14339-1-git-send-email-marc.zyngier@arm.com>
 <1334080601-14339-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <alpine.LFD.2.02.1204101421510.16314@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 10 Apr 2012, Marc Zyngier wrote:

> Some bootloaders are broken enough to expose an ATAG_MEM with
> a null size. Converting such tag to a memory node leads to
> an unbootable system.
> 
> Skip over zero sized ATAG_MEM to avoid this situation.
> 
> Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Nicolas Pitre <nico@linaro.org>


Nicolas
