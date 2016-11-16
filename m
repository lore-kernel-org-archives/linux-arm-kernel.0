From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 16 Nov 2016 12:50:48 -0800
Subject: [PATCH v1 4/4] ARM: dts: Enable interrupt support for cygnus crmu
 gpio driver
In-Reply-To: <1476817238-1226-5-git-send-email-jonathan.richardson@broadcom.com>
References: <1476817238-1226-1-git-send-email-jonathan.richardson@broadcom.com>
 <1476817238-1226-5-git-send-email-jonathan.richardson@broadcom.com>
Message-ID: <29ac3e81-cf47-55af-8583-a8cfce2369de@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/18/2016 12:00 PM, Jonathan Richardson wrote:
> The M0 processor handles interrupts for the always-on CRMU GPIO
> controller. Setting the CRMU GPIO driver with the mailbox controller as
> the interrupt parent allows the mailbox controller to forward interrupts
> from the M0 to the GPIO driver for processing.
> 
> Reviewed-by: Jonathan Richardson <jonathan.richardson@broadcom.com>
> Tested-by: Jonathan Richardson <jonathan.richardson@broadcom.com>
> Reviewed-by: Vikram Prakash <vikram.prakash@broadcom.com>
> Reviewed-by: Shreesha Rajashekar <shreesha.rajashekar@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> Signed-off-by: Jonathan Richardson <jonathan.richardson@broadcom.com>

Applied, thanks
-- 
Florian
