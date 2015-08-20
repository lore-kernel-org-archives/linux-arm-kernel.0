From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Aug 2015 08:43:05 +0200
Subject: [PATCH 1/6] ARM: dts: sun5i: Add simplefb node for tvencoder
 output
In-Reply-To: <1439563477-12295-2-git-send-email-hdegoede@redhat.com>
References: <1439563477-12295-1-git-send-email-hdegoede@redhat.com>
 <1439563477-12295-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20150820064305.GK30520@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, 

On Fri, Aug 14, 2015 at 04:44:32PM +0200, Hans de Goede wrote:
> Add a simplefb node for tvencoder / composite-video output, such as found
> on the Auxtek-T003 and the CHIP.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Queued, thanks!

I guess the CHIP will have to have the same change for the A13 DTSI.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150820/e5078225/attachment.sig>
