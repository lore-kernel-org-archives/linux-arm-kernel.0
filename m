From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 19 Nov 2014 09:34:06 +0100
Subject: [PATCH v2] ARM: dts: sunxi: Update simplfb nodes so that u-boot
 can find them
In-Reply-To: <1416308833-26739-1-git-send-email-hdegoede@redhat.com>
References: <1416308833-26739-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20141119083406.GM6414@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 18, 2014 at 12:07:13PM +0100, Hans de Goede wrote:
> Review of the u-boot sunxi simplefb patches has led to the decision that
> u-boot should not use a specific path to find the nodes as this goes contrary
> to how devicetree usually works.
> 
> Instead a platform specific compatible + properties should be used for this.
> 
> The simplefb bindings have already been updated to reflect this, this patch
> brings the sunxi devicetree files in line with the new binding, and the
> actual u-boot implementation as it is going upstream.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141119/4cbe023f/attachment.sig>
