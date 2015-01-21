From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 21 Jan 2015 09:56:48 +0100
Subject: [PATCH] ARM: dts: sun4i: Add simplefb node with
 de_fe0-de_be0-lcd0-hdmi pipeline
In-Reply-To: <1421672477-12978-2-git-send-email-hdegoede@redhat.com>
References: <1421672477-12978-1-git-send-email-hdegoede@redhat.com>
 <1421672477-12978-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20150121085648.GB4367@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 19, 2015 at 02:01:17PM +0100, Hans de Goede wrote:
> Testing has shown that on sun4i the display backend engine does not have
> deep enough fifo-s causing flickering / tearing in full-hd mode due to
> fifo underruns. This can be avoided by letting the display frontend engine
> do the dma from memory, and then letting it feed the data directly into
> the backend unmodified, as the frontend does have deep enough fifo-s.
> 
> Note since u-boot-v2015.01 has been released using the de_be0-lcd0-hdmi
> pipeline on sun4i, we need to keep that one around too (unfortunately).
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Merged, thanks!

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150121/6efc9082/attachment.sig>
