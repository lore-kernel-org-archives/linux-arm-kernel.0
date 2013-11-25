From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Nov 2013 23:09:55 +0100
Subject: [PATCH V2] dma: tegra: register as an OF DMA controller
In-Reply-To: <1385416416-3536-1-git-send-email-swarren@wwwdotorg.org>
References: <1385416416-3536-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <2205346.2EJcydzRLA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 November 2013 14:53:36 Stephen Warren wrote:
> v2: Use of_dma_slave_xlate() rather than of_dma_simple_xlate(), as
>     suggested by Arnd Bergmann.
> 
> This patch is part of a series with strong internal depdendencies. I'm
> looking for an ack so that I can take the entire series through the Tegra
> and arm-soc trees. The series will be part of a stable branch that can be
> merged into other subsystems if needed to avoid/resolve dependencies.

Did I suggest of_dma_slave_xlate()? I don't think I've actually heard
of that function, and I can't find anything in the kernel source or
using google.

Why not just use an open-coded xlate function?

	Arnd
