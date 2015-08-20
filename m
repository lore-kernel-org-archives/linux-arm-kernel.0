From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Aug 2015 17:04:24 +0200
Subject: [PATCH 5/6] ARM: dts: sun7i: Enable USB DRC on cubieboard2
In-Reply-To: <1439563477-12295-6-git-send-email-hdegoede@redhat.com>
References: <1439563477-12295-1-git-send-email-hdegoede@redhat.com>
 <1439563477-12295-6-git-send-email-hdegoede@redhat.com>
Message-ID: <20150820150424.GA30520@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 14, 2015 at 04:44:36PM +0200, Hans de Goede wrote:
> From: Ralph Benadski <benadski@gmail.com>
> 
> Enable the otg/drc usb controller on the cubieboard2.
> 
> Note this board has the otg-vbus connected directly to the 5v-dcc of
> the board, so there is no vbus0 regulator, nor vbus0-det.
> 
> Signed-off-by: Ralph Benadski <benadski@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Queued, thanks!

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150820/342e3c86/attachment.sig>
