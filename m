From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Fri, 9 Nov 2012 09:07:27 +0100
Subject: [PATCH v2 06/10] pwm: pwm-tiehrpwm: Add device-tree binding
 support for EHRPWM driver
In-Reply-To: <1352361197-27442-7-git-send-email-avinashphilip@ti.com>
References: <1352361197-27442-1-git-send-email-avinashphilip@ti.com>
 <1352361197-27442-7-git-send-email-avinashphilip@ti.com>
Message-ID: <20121109080727.GA26007@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 08, 2012 at 01:23:13PM +0530, Philip, Avinash wrote:
> This patch
> 1. Add support for device-tree binding for EHRWPM driver.
> 2. Set size of pwm-cells set to 3 to support PWM channel number, PWM
>    period & polarity configuration from device tree.
> 3. Add enable/disable clock gating in PWM subsystem common config space.
> 4. When here set .owner member in platform_driver structure to
>    THIS_MODULE.
> 
> Signed-off-by: Philip, Avinash <avinashphilip@ti.com>
> Cc:	Grant Likely <grant.likely@secretlab.ca>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Rob Landley <rob@landley.net>
> ---
> Changes since v1:
> 	- Add separate patch for pinctrl support
> 	- Add conditional check for PWM subsystem clock enable.
> 	- Combined with HWMOD changes & DT bindings.
> 	- Remove the custom of xlate support.
> 
> :000000 100644 0000000... aa2ed0a... A	Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
> :100644 100644 d3c1dff... fba7f9b... M	drivers/pwm/pwm-tiehrpwm.c
>  .../devicetree/bindings/pwm/pwm-tiehrpwm.txt       |   25 ++++++++++
>  drivers/pwm/pwm-tiehrpwm.c                         |   49 +++++++++++++++++++-
>  2 files changed, 72 insertions(+), 2 deletions(-)

The same comments apply as for the pwm-tiecap driver patch.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121109/207bb981/attachment.sig>
