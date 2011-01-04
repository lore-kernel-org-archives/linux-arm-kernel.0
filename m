From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 4 Jan 2011 10:06:18 +0000
Subject: [PATCH 3/4] ARM: module support for CONFIG_ARM_PATCH_PHYS_VIRT
In-Reply-To: <1294129208-15201-4-git-send-email-nico@fluxnic.net>
References: <1294129208-15201-1-git-send-email-nico@fluxnic.net>
	<1294129208-15201-4-git-send-email-nico@fluxnic.net>
Message-ID: <20110104100618.GA16671@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 04, 2011 at 03:20:07AM -0500, Nicolas Pitre wrote:
> Thanks to Russell King for his contribution to this patch.
> 
> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>

This should all be part of the patch introducing the patching - without
it you will end up with a kernel which has the dynamic P:V translation
support but the modules will be buggered.
