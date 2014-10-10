From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 10 Oct 2014 23:04:41 +0200
Subject: [PATCH v4] arm/arm64: KVM: map MMIO regions at creation time
In-Reply-To: <1412953232-11699-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1412953232-11699-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20141010210441.GE3717@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 10, 2014 at 05:00:32PM +0200, Ard Biesheuvel wrote:
> There is really no point in faulting in memory regions page by page
> if they are not backed by demand paged system RAM but by a linear
> passthrough mapping of a host MMIO region. So instead, detect such
> regions at setup time and install the mappings for the backing all
> at once.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
