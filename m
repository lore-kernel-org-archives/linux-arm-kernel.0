From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Thu, 06 Mar 2014 13:42:54 +0100
Subject: [RESEND PATCH 1/1] arm: dts: am33xx: correcting dt node unit
 address for usb
In-Reply-To: <1394109094-19205-1-git-send-email-mugunthanvnm@ti.com>
References: <1394109094-19205-1-git-send-email-mugunthanvnm@ti.com>
Message-ID: <53186D4E.4000706@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/06/2014 01:31 PM, Mugunthan V N wrote:
> DT node's unit address should be its own register offset address to make it a
> unique across the system. This patch corrects the incorrect USB entries with
> correct register offset for unit address.
> 
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>

Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
