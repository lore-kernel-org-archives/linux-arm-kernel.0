From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue, 7 Jun 2016 09:37:59 +0100
Subject: [STLinux Kernel] [PATCH 6/7] phy: miphy28lp: Inform the reset
 framework that our reset line may be shared
In-Reply-To: <20160606155655.10860-7-lee.jones@linaro.org>
References: <20160606155655.10860-1-lee.jones@linaro.org>
 <20160606155655.10860-7-lee.jones@linaro.org>
Message-ID: <20160607083759.GA22960@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 06 Jun 2016, Lee Jones wrote:

> On the STiH410 B2120 development board the MiPHY28lp shares its reset
> line with the Synopsys DWC3 SuperSpeed (SS) USB 3.0 Dual-Role-Device
> (DRD).  New functionality in the reset subsystems forces consumers to
> be explicit when requesting shared/exclusive reset lines.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/phy/phy-miphy28lp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Peter Griffin <peter.griffin@linaro.org>
