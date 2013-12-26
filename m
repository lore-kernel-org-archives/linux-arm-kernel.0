From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 26 Dec 2013 12:58:23 -0500
Subject: [PATCH v3 1/3] clocksource: timer-keystone: introduce clocksource
 driver for Keystone
In-Reply-To: <1387974724-31138-2-git-send-email-ivan.khoronzhuk@ti.com>
References: <1387974724-31138-1-git-send-email-ivan.khoronzhuk@ti.com>
 <1387974724-31138-2-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <52BC6E3F.9060204@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 December 2013 07:32 AM, Ivan Khoronzhuk wrote:
> Add broadcast clock-event device for the Keystone arch.
> 
> The timer can be configured as a general-purpose 64-bit timer,
> dual general-purpose 32-bit timers. When configured as dual 32-bit
> timers, each half can operate in conjunction (chain mode) or
> independently (unchained mode) of each other.
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
> ---
Thanks for the update Ivan. This version looks good to me.

Acked-by: Santosh shilimkar <santosh.shilimkar@ti.com>
