From: wsa-dev@sang-engineering.com (Wolfram Sang)
Date: Thu, 24 Nov 2016 16:18:39 +0100
Subject: [PATCH 1/2] i2c: designware: report short transfers
In-Reply-To: <E1c7p12-0000R0-S8@rmk-PC.armlinux.org.uk>
References: <20161118193542.GO1041@n2100.armlinux.org.uk>
 <E1c7p12-0000R0-S8@rmk-PC.armlinux.org.uk>
Message-ID: <20161124151839.GG4271@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 18, 2016 at 07:40:04PM +0000, Russell King wrote:
> Rather than reporting success for a short transfer due to interrupt
> latency, report an error both to the caller, as well as to the kernel
> log.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Applied to for-current, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161124/956359d1/attachment.sig>
