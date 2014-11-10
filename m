From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 10 Nov 2014 18:42:27 +0000
Subject: [PATCH v8 04/13] arm64: introduce is_device_dma_coherent
In-Reply-To: <1415636045-24669-4-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1411101607130.22875@kaball.uk.xensource.com>
 <1415636045-24669-4-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <20141110184226.GI25609@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 10, 2014 at 04:13:56PM +0000, Stefano Stabellini wrote:
> Introduce a boolean flag and an accessor function to check whether a
> device is dma_coherent. Set the flag from set_arch_dma_coherent_ops.
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

BTW, why do I sign off this patch? As long as it's you as author, I
don't think you should add my sign-off.

-- 
Catalin
