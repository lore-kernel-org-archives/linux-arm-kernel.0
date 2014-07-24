From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 24 Jul 2014 14:57:50 +0200
Subject: [PATCH 0/2] pinctrl: sunxi: misc improvements for gpio
In-Reply-To: <CACRpkdZhZkB6=_ehVXxWAnvkVYy_KOU84fcGRSRTc9-2X2paqQ@mail.gmail.com>
References: <1405358677-23657-1-git-send-email-wens@csie.org>
 <CACRpkdZhZkB6=_ehVXxWAnvkVYy_KOU84fcGRSRTc9-2X2paqQ@mail.gmail.com>
Message-ID: <20140724125750.GY20328@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 22, 2014 at 06:33:10PM +0200, Linus Walleij wrote:
> > AFAIK pinctrl pin numbers are device specific, so I'm wondering if we
> > should also number them in terms of offsets, rather than absolute pin
> > numbers. It's more of an asthetic change though. Any thoughts?
> 
> Usually I say these pin numbers should try to match what is
> in the data sheet so it is easy to understand and debug. Sometimes
> pins are numbered with letters and stuff so they rather have names
> than numbers, then some artificial numbering is applied, whatever
> is helpful.
> 
> I'm not directly familiar with the sunxi numbering system though...

I'd prefer if we had an absolute number that more or less matches the
one in the datasheet.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140724/ed4c4083/attachment.sig>
