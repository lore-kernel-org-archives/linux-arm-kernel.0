From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 20 May 2014 14:16:57 +0200
Subject: [PATCH] ARM: sun6i: Enable USB Host support on the Colombus board
In-Reply-To: <537B4587.5020803@redhat.com>
References: <1400587155-19387-1-git-send-email-maxime.ripard@free-electrons.com>
 <537B4587.5020803@redhat.com>
Message-ID: <20140520121657.GG27329@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, May 20, 2014 at 02:07:35PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 05/20/2014 01:59 PM, Maxime Ripard wrote:
> > The colombus board has a on-board USB hub, that is enabled through the pin
> > PH24, and wired to the first EHCI controller.
> 
> ehci0 is not hooked up at all on this board ? I would expect it to go to
> a usb wifi card for example.
> 
> Assuming that ehci0 is not hooked up, this is:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

It's unclear, because the schematics say that we have two options,
either USB or SDIO wifi chips.

However, looking at the boards, it looks like it's the latter.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140520/8c74ab48/attachment.sig>
