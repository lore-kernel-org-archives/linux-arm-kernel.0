From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 30 Jul 2016 17:13:34 +0200
Subject: [PATCH v2 1/5] mmc: sunxi: Disable sample clks on remove
In-Reply-To: <1469888748-26085-2-git-send-email-hdegoede@redhat.com>
References: <1469888748-26085-1-git-send-email-hdegoede@redhat.com>
 <1469888748-26085-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20160730151334.GN6215@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 30, 2016 at 04:25:44PM +0200, Hans de Goede wrote:
> When support for the sample clks was added calls to prepare_enable
> were added to the probe path, but matching calls to disable_unprepare
> were forgotten in the remove path, this fixes this.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160730/6fbabca6/attachment.sig>
