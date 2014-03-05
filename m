From: mporter@linaro.org (Matt Porter)
Date: Wed, 5 Mar 2014 01:37:28 -0500
Subject: [PATCH v2] ARM: dts: remove bcm11351-brt.dts
In-Reply-To: <1392845512-31333-1-git-send-email-mporter@linaro.org>
References: <1392845512-31333-1-git-send-email-mporter@linaro.org>
Message-ID: <20140305063728.GB25092@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 19, 2014 at 04:31:52PM -0500, Matt Porter wrote:
> The BCM11351 BRT board will never see the light of day. Remove the BRT
> dts since it is not maintainable.
> 
> Reviewed-by: Alex Elder <elder@linaro.org>
> Signed-off-by: Matt Porter <mporter@linaro.org>
> ---
> Changes since v1:
> 	- remove bcm11351-brt from Makefile
> 

Applied to mach-bcm for-3.15/dt

-Matt
