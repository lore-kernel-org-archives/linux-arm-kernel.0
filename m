From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 May 2016 15:05:11 +0200
Subject: [PATCH v2] arm64: Allow for different DMA and CPU bus offsets
In-Reply-To: <1463576010-115428-1-git-send-email-agraf@suse.de>
References: <1463576010-115428-1-git-send-email-agraf@suse.de>
Message-ID: <3627660.euTtGW2SrX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 May 2016 14:53:30 Alexander Graf wrote:
> On arm64, all SoCs we supported so far either have an IOMMU or have bus
> addresses equal to CPU addresses.
> 
> However, with the Raspberry Pi 3 coming up, this is no longer true. To
> allow DMA to work with an AArch64 kernel on those devices, let's allow
> devices to have DMA offsets again.
> 
> Signed-off-by: Alexander Graf <agraf@suse.de>
> 
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
