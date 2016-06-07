From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue, 7 Jun 2016 09:36:00 +0100
Subject: [STLinux Kernel] [PATCH 7/7] usb: dwc3: st: Inform the reset
 framework that our reset line may be shared
In-Reply-To: <20160606155655.10860-8-lee.jones@linaro.org>
References: <20160606155655.10860-1-lee.jones@linaro.org>
 <20160606155655.10860-8-lee.jones@linaro.org>
Message-ID: <20160607083600.GD22744@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Mon, 06 Jun 2016, Lee Jones wrote:

> On the STiH410 B2120 development board the MiPHY28lp shares its reset
> line with the Synopsys DWC3 SuperSpeed (SS) USB 3.0 Dual-Role-Device
> (DRD).  New functionality in the reset subsystems forces consumers to
> be explicit when requesting shared/exclusive reset lines.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/usb/dwc3/dwc3-st.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Acked-by: Peter Griffin <peter.griffin@linaro.org>
