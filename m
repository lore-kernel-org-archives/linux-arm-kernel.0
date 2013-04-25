From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 25 Apr 2013 13:34:45 -0400
Subject: [PATCH 04/21] ARM: orion5x: include linux/cpu.h
In-Reply-To: <1366910944-3033663-5-git-send-email-arnd@arndb.de>
References: <1366910944-3033663-1-git-send-email-arnd@arndb.de>
 <1366910944-3033663-5-git-send-email-arnd@arndb.de>
Message-ID: <20130425173445.GD32497@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 25, 2013 at 07:28:47PM +0200, Arnd Bergmann wrote:
> The linux/cpu.h header is no longer implictly included in this
> file, so we need to an #include statement to avoid this build
> warning:
> 
> arch/arm/mach-orion5x/common.c:339:3: error: implicit declaration of function 'cpu_idle_poll_ctrl' [-Werror=implicit-function-declaration]
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/mach-orion5x/common.c | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Jason Cooper <jason@lakedaemon.net>

I imagine it's easiest for you to take this through a branch you already
have set up, so have it.

thx,

Jason.
