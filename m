From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 17 Dec 2013 15:43:55 -0500
Subject: [PATCH v2 2/3] clocksource: keystone: add bindings for keystone
 timer
In-Reply-To: <1387297337-25493-3-git-send-email-ivan.khoronzhuk@ti.com>
References: <1387297337-25493-1-git-send-email-ivan.khoronzhuk@ti.com>
 <1387297337-25493-3-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <52B0B78B.2060102@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 December 2013 11:22 AM, Ivan Khoronzhuk wrote:
> This patch provides bindings for the 64-bit timer in the KeyStone
> architecture devices. The timer can be configured as a general-purpose 64-bit
> timer, dual general-purpose 32-bit timers. When configured as dual 32-bit
> timers, each half can operate in conjunction (chain mode) or independently
> (unchained mode) of each other.
> 
> It is global timer is a free running up-counter and can generate interrupt
> when the counter reaches preset counter values.
> 
> Documentation:
> http://www.ti.com/lit/ug/sprugv5a/sprugv5a.pdf
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
