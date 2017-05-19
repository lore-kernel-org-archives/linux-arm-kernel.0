From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 19 May 2017 09:19:22 +0200
Subject: [linux-sunxi] [PATCH v6 9/9] arm64: allwinner: a64: enable Wi-Fi
 for Pine64
In-Reply-To: <79B00D42-3F95-4D5E-9A23-8E893CCF2462@aosc.io>
References: <20170518071653.36561-1-icenowy@aosc.io>
 <20170518071653.36561-10-icenowy@aosc.io>
 <CAGb2v66mqMveibKKU9LiBm8jzAOj46hFCK6HvJx0k6077fqLZw@mail.gmail.com>
 <79B00D42-3F95-4D5E-9A23-8E893CCF2462@aosc.io>
Message-ID: <20170519071922.awmib4qphl6ac6mj@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 19, 2017 at 11:03:33AM +0800, Icenowy Zheng wrote:
> >The patch looks OK, but given the module is removable, I think it
> >should be
> >an overlay. The overlay would enable WiFi + Bluetooth, and all the
> >peripherals needed to connect them.
> >
> >That way, if the module is not installed, we avoid confusing the user
> >with
> >unused peripherals, and avoid having live voltage on an unoccupied
> >header.
> 
> But as this header have specific usage, we will also confuse user
> if it's not enabled as its target usage.

Yet you would enable unused resources.

This was already pointed out here:
https://patchwork.kernel.org/patch/9670235/

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170519/259493c5/attachment.sig>
