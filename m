From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 2 Jun 2015 09:51:20 +0200
Subject: [PATCH v2 3/6] ARM: dts: sun8i: Add sun8i-a23-a33 dtsi
In-Reply-To: <1432997706-20172-4-git-send-email-hdegoede@redhat.com>
References: <1432997706-20172-1-git-send-email-hdegoede@redhat.com>
 <1432997706-20172-4-git-send-email-hdegoede@redhat.com>
Message-ID: <20150602075120.GL23777@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 30, 2015 at 04:55:03PM +0200, Hans de Goede wrote:
> From: Vishnu Patekar <vishnupatekar0510@gmail.com>
> 
> Rename sun8i-a23.dtsi to sun8i-a23-a33.dtsi as the base dtsi for the A33
> is 99% the same and add a new sun8i-a23.dtsi including sun8i-a23-a33.dtsi
> and setting the few things not shared with the A33 (mbus-clk, pio
> compatible and interrupts).
> 
> Signed-off-by: Vishnu Patekar <vishnupatekar0510@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Fixed the conflicts and applied.

Also judging from a quick look at the datasheet, the A33 doesn't seem
to have that clock gates tree but rather one similar to the H3's. That
will probably mean we'll have to move out the gates from this DTSI at
some point.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150602/b43e1c69/attachment.sig>
