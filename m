From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue, 7 Jun 2016 09:36:32 +0100
Subject: [STLinux Kernel] [PATCH 8/10] phy: phy-stih407-usb: Inform the
 reset framework that our reset line may be shared
In-Reply-To: <20160606170854.12407-1-lee.jones@linaro.org>
References: <20160606155655.10860-8-lee.jones@linaro.org>
 <20160606170854.12407-1-lee.jones@linaro.org>
Message-ID: <20160607083632.GE22744@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 06 Jun 2016, Lee Jones wrote:

> On the STiH410 B2120 development board the ports on the Generic PHY
> share their reset lines with each other.  New functionality in the
> reset subsystems forces consumers to be explicit when requesting
> shared/exclusive reset lines.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Peter Griffin <peter.griffin@linaro.org>
