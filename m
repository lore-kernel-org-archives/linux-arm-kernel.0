From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 22 Feb 2014 22:44:21 +0100
Subject: [PATCH v7 13/15] ARM: sun4i: dt: Remove grouping + simple-bus
 compatible for regulators
In-Reply-To: <1393084424-31099-14-git-send-email-hdegoede@redhat.com>
References: <1393084424-31099-1-git-send-email-hdegoede@redhat.com>
 <1393084424-31099-14-git-send-email-hdegoede@redhat.com>
Message-ID: <20140222214421.GC3610@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Feb 22, 2014 at 04:53:42PM +0100, Hans de Goede wrote:
> According to Documentation/devicetree/bindings/regulator/regulator.txt
> regulator nodes should not be placed under 'simple-bus'.
> 
> Mark Rutland also explains about it at:
> http://www.spinics.net/lists/linux-usb/msg101497.html
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied in my sunxi/dt-for-3.15 branch.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140222/6179fd74/attachment.sig>
