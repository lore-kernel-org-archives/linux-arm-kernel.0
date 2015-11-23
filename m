From: will.deacon@arm.com (Will Deacon)
Date: Mon, 23 Nov 2015 13:29:38 +0000
Subject: [PATCH v2 4/4] drivers: psci: replace psci firmware calls
In-Reply-To: <1447236266-7491-5-git-send-email-jens.wiklander@linaro.org>
References: <1447236266-7491-1-git-send-email-jens.wiklander@linaro.org>
 <1447236266-7491-5-git-send-email-jens.wiklander@linaro.org>
Message-ID: <20151123132938.GF2755@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 11, 2015 at 11:04:26AM +0100, Jens Wiklander wrote:
> Switch to use a generic interface for issuing SMC/HVC based on ARM SMC
> Calling Convention. Removes now the now unused psci-call.S.
> 
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  arch/arm/kernel/Makefile      |  1 -
>  arch/arm/kernel/psci-call.S   | 31 -------------------------------
>  arch/arm64/kernel/Makefile    |  2 +-
>  arch/arm64/kernel/psci-call.S | 28 ----------------------------
>  drivers/firmware/psci.c       | 23 +++++++++++++++++++++--
>  5 files changed, 22 insertions(+), 63 deletions(-)
>  delete mode 100644 arch/arm/kernel/psci-call.S
>  delete mode 100644 arch/arm64/kernel/psci-call.S

Thanks for doing this:

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
