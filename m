From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 8 Apr 2016 22:46:49 +0200
Subject: [PATCH 0/6] ARM/ARM64: Drop arm_pm_restart
In-Reply-To: <1460120039-2497-1-git-send-email-linux@roeck-us.net>
References: <1460120039-2497-1-git-send-email-linux@roeck-us.net>
Message-ID: <201604082246.49653.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 08 April 2016, Guenter Roeck wrote:
> This is the final push to replace arm_pm_restart with the kernel restart
> handler. Finally drop arm_pm_restart after it is no longer used.
> The following changes since commit 541d8f4d59d79f5d37c8c726f723d42ff307db57:

Looks good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>
