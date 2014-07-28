From: mporter@linaro.org (Matt Porter)
Date: Mon, 28 Jul 2014 10:27:38 -0400
Subject: [PATCH] devicetree: bindings: document Broadcom CPU enable method
In-Reply-To: <1404166185-4168-1-git-send-email-elder@linaro.org>
References: <1404166185-4168-1-git-send-email-elder@linaro.org>
Message-ID: <20140728142738.GA2593@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 05:09:45PM -0500, Alex Elder wrote:
> Broadcom mobile SoCs use a ROM-implemented holding pen for
> controlled boot of secondary cores.  A special register is
> used to communicate to the ROM that a secondary core should
> start executing kernel code.  This enable method is currently
> used for members of the bcm281xx and bcm21664 SoC families.
> 
> The use of an enable method also allows the SMP operation vector to
> be assigned as a result of device tree content for these SoCs.
> 
> Signed-off-by: Alex Elder <elder@linaro.org>

Applied to mach-bcm for-3.17/dt

Thanks,
Matt
