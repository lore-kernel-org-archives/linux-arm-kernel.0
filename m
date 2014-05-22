From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 22 May 2014 18:11:48 +0100
Subject: [Patch v6 3/7] mfd: ti-keystone-devctrl: add bindings for device
 state control
In-Reply-To: <1400777062-19276-4-git-send-email-ivan.khoronzhuk@ti.com>
References: <1400777062-19276-1-git-send-email-ivan.khoronzhuk@ti.com>
 <1400777062-19276-4-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <20140522171148.GL19747@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 22 May 2014, Ivan Khoronzhuk wrote:

> The Keystone II devices have a set of registers that are used to control
> the status of its peripherals. This node is intended to allow access to
> this functionality.
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
> ---
>  .../devicetree/bindings/mfd/ti-keystone-devctrl.txt   | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ti-keystone-devctrl.txt

Applied, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
