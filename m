From: balbi@ti.com (Felipe Balbi)
Date: Mon, 15 Jul 2013 12:26:33 +0300
Subject: [PATCH] arm: omap5: dts: add palmas-usb node
In-Reply-To: <1373645681-29779-1-git-send-email-balbi@ti.com>
References: <1373645681-29779-1-git-send-email-balbi@ti.com>
Message-ID: <20130715092633.GC14330@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 12, 2013 at 07:14:41PM +0300, Felipe Balbi wrote:
> Without this node, there will be no palmas
> driver to notify dwc3 that a cable has
> been connected and, without that, dwc3
> will never initialize.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
> 
> after this, all we need is wait EXTCON merge
> which contains the final changes necessary
> to get USB3 working out of the box.
> 
> I'd suggest waiting on this patch until EXTCON
> reaches mainline, just to make sure we don't
> end up with DTS data for devices which don't
> exist.

this is not entirely correct. v3.11-rc1 has almost everything we need,
already have a newer version of this patch but dwc3 has decided not to
behave.

don't apply this version

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130715/5843200f/attachment.sig>
