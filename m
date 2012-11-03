From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 3 Nov 2012 21:42:20 +0530
Subject: [PATCH 03/15] ARM: OMAP: mailbox: Convert to device_initcall
In-Reply-To: <1351859566-24818-4-git-send-email-vaibhav.bedia@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-4-git-send-email-vaibhav.bedia@ti.com>
Message-ID: <50954264.50000@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 02 November 2012 06:02 PM, Vaibhav Bedia wrote:
> The power management code for AM33XX is a late_initcall
> and the PM features depend on the mailbox for IPC.
> In preparation for this, convert the mailbox init to
> a device_initcall.
>
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> ---
Looks fine
