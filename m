From: sre@kernel.org (Sebastian Reichel)
Date: Thu, 21 Aug 2014 22:39:04 +0200
Subject: [PATCH v7 02/11] power/restart: Call machine_restart instead of
 arm_pm_restart
In-Reply-To: <1408495538-27480-3-git-send-email-linux@roeck-us.net>
References: <1408495538-27480-1-git-send-email-linux@roeck-us.net>
 <1408495538-27480-3-git-send-email-linux@roeck-us.net>
Message-ID: <20140821203904.GA26620@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 19, 2014 at 05:45:29PM -0700, Guenter Roeck wrote:
> machine_restart is supported on non-ARM platforms, and and ultimately calls
> arm_pm_restart, so dont call arm_pm_restart directly but use the more
> generic function.
> 
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Heiko Stuebner <heiko@sntech.de>

Acked-by: Sebastian Reichel <sre@kernel.org>

Do you want me to take the patch via battery-2.6.git?

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140821/9a65832c/attachment.sig>
