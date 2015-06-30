From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 30 Jun 2015 15:20:13 +0200
Subject: [PATCH v3 03/11] KVM: arm: enable to use the ARM_DSCR_MDBGEN
 macro from KVM assembly code
In-Reply-To: <1434969694-7432-4-git-send-email-zhichao.huang@linaro.org>
References: <1434969694-7432-1-git-send-email-zhichao.huang@linaro.org>
 <1434969694-7432-4-git-send-email-zhichao.huang@linaro.org>
Message-ID: <20150630132013.GT11332@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 22, 2015 at 06:41:26PM +0800, Zhichao Huang wrote:
> Add #ifndef __ASSEMBLY__ in hw_breakpoint.h, in order to use
> the ARM_DSCR_MDBGEN macro from KVM assembly code.
> 
> Signed-off-by: Zhichao Huang <zhichao.huang@linaro.org>
> Reviewed-by: Alex Bennee <alex.bennee@linaro.org>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
