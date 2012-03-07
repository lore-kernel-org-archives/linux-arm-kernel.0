From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 07 Mar 2012 13:03:50 +0100
Subject: [PATCH v3 10/13] gpio/omap: fix missing dataout context save
 in _set_gpio_dataout_reg
In-Reply-To: <1331118963-26364-11-git-send-email-tarun.kanti@ti.com>
References: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com>
 <1331118963-26364-11-git-send-email-tarun.kanti@ti.com>
Message-ID: <4F574EA6.4000807@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 March 2012 12:16 PM, Tarun Kanti DebBarma wrote:
> There are two functions, _set_gpio_dataout_reg() and _set_gpio_dataout_mask()
> which writes to dataout register and the dataout context must be saved.
> It is missing in the first function, _set_gpio_dataout_reg(). Fix this.
> 
> Reported-by: Govindraj Raja <govindraj.raja@ti.com>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> ---
Good catch. Is the suspend/resume caught this issue?

This can go as a fix as well.

Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
Santosh
