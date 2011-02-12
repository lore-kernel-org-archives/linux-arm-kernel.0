From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 12 Feb 2011 12:16:09 +0000
Subject: [PATCH V2 3/4] ARM: Xilinx: base header files and assembly macros
In-Reply-To: <e19bc079-5f8a-4622-b7cd-668cede3cb97@VA3EHSMHS032.ehs.local>
References: <1297270845-18802-1-git-send-email-john.linn@xilinx.com>
	<1297270845-18802-2-git-send-email-john.linn@xilinx.com>
	<1297270845-18802-3-git-send-email-john.linn@xilinx.com>
	<e19bc079-5f8a-4622-b7cd-668cede3cb97@VA3EHSMHS032.ehs.local>
Message-ID: <20110212121609.GI15616@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 09, 2011 at 10:00:44AM -0700, John Linn wrote:
> +#ifndef __MACH_VMALLOC_H__
> +#define __MACH_VMALLOC_H__
> +
> +#define VMALLOC_END       0xE0000000

Should have a UL suffix on this.
