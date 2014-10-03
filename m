From: sre@kernel.org (Sebastian Reichel)
Date: Fri, 3 Oct 2014 16:27:18 +0200
Subject: [RFC PATCH 15/16] power/reset: restart-poweroff: Register with
 kernel poweroff handler
In-Reply-To: <1412100056-15517-16-git-send-email-linux@roeck-us.net>
References: <1412100056-15517-1-git-send-email-linux@roeck-us.net>
 <1412100056-15517-16-git-send-email-linux@roeck-us.net>
Message-ID: <20141003142718.GA8291@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Sep 30, 2014 at 11:00:55AM -0700, Guenter Roeck wrote:
> Register with kernel poweroff handler instead of seting pm_power_off
> directly.  Register as poweroff handler of last resort since the driver
> does not really power off the system but executes a restart.
> 
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141003/3e06131f/attachment.sig>
