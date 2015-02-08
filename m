From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 8 Feb 2015 17:29:37 +0100
Subject: [PATCH v9 2/3] i2c: iproc: Add Broadcom iProc I2C Driver
In-Reply-To: <1423373126-30024-3-git-send-email-rjui@broadcom.com>
References: <rjui@broadcom.com>
 <1423373126-30024-1-git-send-email-rjui@broadcom.com>
 <1423373126-30024-3-git-send-email-rjui@broadcom.com>
Message-ID: <20150208162937.GB6033@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 07, 2015 at 09:25:25PM -0800, Ray Jui wrote:
> Add initial support to the Broadcom iProc I2C controller found in the
> iProc family of SoCs.
> 
> The iProc I2C controller has separate internal TX and RX FIFOs, each has
> a size of 64 bytes. The iProc I2C controller supports two bus speeds
> including standard mode (100kHz) and fast mode (400kHz)
> 
> Signed-off-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>
> Reviewed-by: Kevin Cernekee <cernekee@chromium.org>

Looks good. What kind of tests have you done with exactly this version of the
driver (not earlier ones)?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150208/15f140da/attachment.sig>
