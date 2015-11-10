From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Tue, 10 Nov 2015 21:36:35 +0100
Subject: [PATCH v8] can: xilinx: Convert to runtime_pm
In-Reply-To: <1445839914-26249-1-git-send-email-appanad@xilinx.com>
References: <1445839914-26249-1-git-send-email-appanad@xilinx.com>
Message-ID: <56425553.3080909@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/26/2015 07:11 AM, Kedareswara rao Appana wrote:
> Instead of enabling/disabling clocks at several locations in the driver,
> Use the runtime_pm framework. This consolidates the actions for runtime PM
> In the appropriate callbacks and makes the driver more readable and mantainable.
> 
> Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>

Applied to can-next.

thanks,
Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
