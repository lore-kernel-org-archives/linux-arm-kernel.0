From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 8 Apr 2016 17:44:17 +0200
Subject: [PATCH 0/6] ARM/ARM64: Drop arm_pm_restart
In-Reply-To: <1460120039-2497-1-git-send-email-linux@roeck-us.net>
References: <1460120039-2497-1-git-send-email-linux@roeck-us.net>
Message-ID: <20160408154417.GA1388@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 08, 2016 at 05:53:53AM -0700, Guenter Roeck wrote:
> This is the final push to replace arm_pm_restart with the kernel restart
> handler. Finally drop arm_pm_restart after it is no longer used.

Nice! Will check it next week and add the reset_handler to my watchdog.

Thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160408/92dd979c/attachment.sig>
