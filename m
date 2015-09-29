From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 29 Sep 2015 10:04:53 +0200
Subject: [PATCH 2/6] ARM: dts: sun7i: Enable USB DRC on Bananapi
In-Reply-To: <1442928966-6418-2-git-send-email-hdegoede@redhat.com>
References: <1442928966-6418-1-git-send-email-hdegoede@redhat.com>
 <1442928966-6418-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20150929080453.GN7104@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 22, 2015 at 03:36:01PM +0200, Hans de Goede wrote:
> Enable the otg/drc usb controller on the Bananapi.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied all the other patches but this one.

Since we dropped the patch adding the regulators support on the
Bananapi until we figure out why the board crash, it doesn't compile
anymore.

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
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150929/a64e5db6/attachment.sig>
