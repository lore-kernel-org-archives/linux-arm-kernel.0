From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 15 Jan 2013 09:37:20 -0700
Subject: [PATCH] timer: vt8500: Convert vt8500 to use CLKSRC_OF
In-Reply-To: <1358232649-19964-1-git-send-email-linux@prisktech.co.nz>
References: <1358232649-19964-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <50F585C0.20900@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/14/2013 11:50 PM, Tony Prisk wrote:
> This patch converts arch-vt8500 to make use of CLKSRC_OF. Doing so
> removes the need for include/linux/vt8500_timer.h as vt8500_timer_init
> no longer needs to be visible outside vt8500_timer.c

Reviewed-by: Stephen Warren <swarren@nvidia.com>
