From: balbi@ti.com (Felipe Balbi)
Date: Fri, 15 Feb 2013 14:50:55 +0200
Subject: [RFC/RFT PATCH 1/2] ARM: OMAP2+: hwmod-data: UART IP needs
 software control of sidle modes
In-Reply-To: <1360930106-32005-1-git-send-email-santosh.shilimkar@ti.com>
References: <1360930106-32005-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20130215125055.GA16558@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 15, 2013 at 05:38:26PM +0530, Santosh Shilimkar wrote:
> OMAP UART IP needs manual idle modes based on state of the
> IP. Currently this is handled by the driver with function pointers
> implemented in platform code.
> 
> This however breaks in case of device tree because of missing
> idle handling. With the provided flags, idle mode handling is transparently
> handled by runtime time pm code.

this last sentence can be improved a bit.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130215/a3a4cfc0/attachment.sig>
