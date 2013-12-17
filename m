From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 17 Dec 2013 13:44:59 +0100
Subject: [PATCH v3] ARM: sunxi: fix sun5i-a13 port F multiplexing
In-Reply-To: <1387197757-6017-1-git-send-email-hdegoede@redhat.com>
References: <1387197757-6017-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20131217124459.GQ3037@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 16, 2013 at 01:42:37PM +0100, Hans de Goede wrote:
> The correct value for selecting the mmc0 function on port F pins is 2 not 4,
> as per the data-sheet:
> http://dl.linux-sunxi.org/A13/A13%20Datasheet%20-%20v1.12%20%282012-03-29%29.pdf
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131217/8db62dce/attachment.sig>
