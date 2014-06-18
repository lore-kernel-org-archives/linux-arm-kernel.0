From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 18 Jun 2014 11:13:26 +0100
Subject: [PATCH] arm64: remove define of ARCH_HAS_DMA_GET_REQUIRED_MASK
In-Reply-To: <1403024823-2180-1-git-send-email-msalter@redhat.com>
References: <1403024823-2180-1-git-send-email-msalter@redhat.com>
Message-ID: <20140618101326.GB14680@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 06:07:03PM +0100, Mark Salter wrote:
> Arm64 defines ARCH_HAS_DMA_GET_REQUIRED_MASK but provides
> no dma_get_required_mask() function. This leads to a link
> error in drivers using dma_get_required_mask(). Remove the
> define so the default dma_get_required_mask() is available.
> 
> Signed-off-by: Mark Salter <msalter@redhat.com>

I already got a similar patch to push in -rc2.

Thanks.

-- 
Catalin
