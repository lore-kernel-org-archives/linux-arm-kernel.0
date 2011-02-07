From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 07 Feb 2011 14:42:15 +0900
Subject: [RFC] Generic CPU save/restore PM support
In-Reply-To: <20110206191117.GA17808@n2100.arm.linux.org.uk>
References: <20110206191117.GA17808@n2100.arm.linux.org.uk>
Message-ID: <000101cbc689$cceb8f40$66c2adc0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> 
> The following patch series implements infrastructure to save/restore
> CPU state on suspend/resume PM events, and updates SA11x0, PXA and
> Samsung platforms to use this.
> 
> Not all CPU support files are updated with the necessary changes -
> currently only ARM920, ARM926, SA11x0, XScale, XScale3, V6 and V7
> CPUs are supported.
> 
> I've build-tested this for Assabet, PXA, and S3C2410, but not boot
> tested it yet.
> 
Hi Russell,

Occurs following build error with s5pv210_defconfig.
(I applied your patches into my some branch which is based on 38-rc3 for
test)

arch/arm/mm/proc-v7.S:207: error: unterminated #ifdef

Let you know the test result on my board after fixing it.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
