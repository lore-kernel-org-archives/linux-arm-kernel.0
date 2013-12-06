From: balbi@ti.com (Felipe Balbi)
Date: Fri, 6 Dec 2013 14:29:20 -0600
Subject: [PATCH v2 2/5] usb: phy: Add keystone usb phy driver
In-Reply-To: <1386187811-9596-3-git-send-email-w-kwok2@ti.com>
References: <1386187811-9596-1-git-send-email-w-kwok2@ti.com>
 <1386187811-9596-3-git-send-email-w-kwok2@ti.com>
Message-ID: <20131206202920.GH21086@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Dec 04, 2013 at 03:10:08PM -0500, WingMan Kwok wrote:
> Add Keystone platform USB PHY driver support. Current main purpose
> of this driver is to enable the PHY reference clock gate on the
> Keystone SoC. Otherwise it is a nop PHY.
> 
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: WingMan Kwok <w-kwok2@ti.com>

looks good.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131206/3ea2de7e/attachment.sig>
