From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 30 Jun 2010 12:57:43 -0400 (EDT)
Subject: [PATCH 08/33] Removing dead SA1101
In-Reply-To: <7488ec29cdb90212e965f6cd1173141c576c0955.1277911346.git.siccegge@cs.fau.de>
References: <cover.1277911345.git.siccegge@cs.fau.de>
	<7488ec29cdb90212e965f6cd1173141c576c0955.1277911346.git.siccegge@cs.fau.de>
Message-ID: <alpine.LFD.2.00.1006301255260.24097@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 30 Jun 2010, Christoph Egger wrote:

> SA1101 doesn't exist in Kconfig, therefore removing all
> references for it from the source code.
> 
> Signed-off-by: Christoph Egger <siccegge@cs.fau.de>

Acked-by: Nicolas Pitre <nico@fluxnic.net>

> ---
>  arch/arm/mach-sa1100/include/mach/SA-1101.h  |  925 --------------------------
>  arch/arm/mach-sa1100/include/mach/hardware.h |    4 -
>  2 files changed, 0 insertions(+), 929 deletions(-)
>  delete mode 100644 arch/arm/mach-sa1100/include/mach/SA-1101.h
> 
[...]


Nicolas
