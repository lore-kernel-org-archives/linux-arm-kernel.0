From: olof@lixom.net (Olof Johansson)
Date: Thu, 29 May 2014 12:43:00 -0700
Subject: [PATCH] ARM: kconfig: allow PCI support to be selected with
 ARCH_MULTIPLATFORM
In-Reply-To: <1401229595-524-1-git-send-email-will.deacon@arm.com>
References: <1401229595-524-1-git-send-email-will.deacon@arm.com>
Message-ID: <20140529194300.GH18481@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 27, 2014 at 11:26:35PM +0100, Will Deacon wrote:
> When targetting ARCH_MULTIPLATFORM, we may include support for SoCs with
> PCI-capable devices (e.g. mach-virt with virtio-pci).
> 
> This patch allows PCI support to be selected for these SoCs by selecting
> CONFIG_MIGHT_HAVE_PCI when CONFIG_ARCH_MULTIPLATFORM=y and removes the
> individual selections from multi-platform enabled SoCs.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
> 
> Hi Arnd, Olof, Kevin,
> 
> Please can you take this patch via the arm-soc tree for 3.16? It doesn't
> really fit with the generic PCI host driver that I'll send via Bjorn and
> it seems OTT to send you a pull request containing just this patch.
> 

Thanks, applied to next/cleanup.


-Olof
