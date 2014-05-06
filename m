From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 06 May 2014 09:26:03 +0200
Subject: [PATCH] PCI: Turn pcibios_penalize_isa_irq() into __weak function
In-Reply-To: <1399346992-6584-1-git-send-email-hanjun.guo@linaro.org>
References: <1399346992-6584-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <4534160.Diq8cthzci@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 06 May 2014 11:29:52 Hanjun Guo wrote:
> pcibios_penalize_isa_irq() is only useful for x86 now, and
> legacy ISA is not used by some architectures, so make
> pcibios_penalize_isa_irq() as __weak function to simplify
> the code, this will prevent new platform from introducing
> dummy stub function for pcibios_penalize_isa_irq() too.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
