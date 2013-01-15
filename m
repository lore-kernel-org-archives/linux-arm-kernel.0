From: olof@lixom.net (Olof Johansson)
Date: Tue, 15 Jan 2013 11:00:09 -0800
Subject: [PATCH] timer: vt8500: Convert vt8500 to use CLKSRC_OF
In-Reply-To: <1358232649-19964-1-git-send-email-linux@prisktech.co.nz>
References: <1358232649-19964-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <20130115190009.GA28251@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 15, 2013 at 07:50:49PM +1300, Tony Prisk wrote:
> This patch converts arch-vt8500 to make use of CLKSRC_OF. Doing so
> removes the need for include/linux/vt8500_timer.h as vt8500_timer_init
> no longer needs to be visible outside vt8500_timer.c
> 
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> ---
> Hi Olof,
> 
> Here is the fix as requested by Stephen Warren, based on vt8500/timer.

Applied, thanks.


-Olof
