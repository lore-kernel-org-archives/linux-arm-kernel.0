From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 31 Jul 2015 12:08:22 +0200
Subject: [PATCH 4/5] ARM: dts: sun8i: Enable USB DRC on Ippo Q8H-A33 tablet
In-Reply-To: <1438333194-21181-5-git-send-email-hdegoede@redhat.com>
References: <1438333194-21181-1-git-send-email-hdegoede@redhat.com>
 <1438333194-21181-5-git-send-email-hdegoede@redhat.com>
Message-ID: <20150731100822.GA2564@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jul 31, 2015 at 10:59:53AM +0200, Hans de Goede wrote:
> Enable the otg/drc usb controller on the Ippo Q8H-A33 tablet, for now it
> is enabled in host-only mode, because true OTG support requires support
> for detecting and enabling Vbus through the axp221 pmic.
> 
> For this to work the Vbus on the port must be enabled by u-boot,
> or a powered hub must be used.

A comment on top of the usb_otg node stating that would be great. It
stands out more when we want to refactor stuff (with a FIXME even?).

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150731/89653bd6/attachment.sig>
