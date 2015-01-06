From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 6 Jan 2015 11:05:05 +0100
Subject: [PATCH v3 2/3] ARM: dts: sun6i: Add sun6i-a31s.dtsi
In-Reply-To: <1419851366-21945-2-git-send-email-hdegoede@redhat.com>
References: <1419851366-21945-1-git-send-email-hdegoede@redhat.com>
 <1419851366-21945-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20150106100505.GI7853@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 29, 2014 at 12:09:25PM +0100, Hans de Goede wrote:
> Add a dtsi file for A31s based boards.
> 
> Since the  A31s is the same die as the A31 in a different package, this dtsi
> simply includes sun6i-a31.dtsi and then overrides the pinctrl compatible to
> reflect the different package, everything else is identical.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150106/89827748/attachment.sig>
