From: eric@anholt.net (Eric Anholt)
Date: Mon, 02 May 2016 08:34:28 -0700
Subject: [PATCH v5] ARM: bcm2835: dt: Add the ethernet to the device trees
In-Reply-To: <1462172811-24206-1-git-send-email-lkundrak@v3.sk>
References: <1462172811-24206-1-git-send-email-lkundrak@v3.sk>
Message-ID: <8737q0iid7.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lubomir Rintel <lkundrak@v3.sk> writes:

> The hub and the ethernet in its port 1 are hardwired on the board.
>
> Compared to the adapters that can be plugged into the USB ports, this
> one has no serial EEPROM to store its MAC. Nevertheless, the Raspberry Pi
> has the MAC address for this adapter in its ROM, accessible from its
> firmware.
>
> U-Boot can read out the address and set the local-mac-address property of the
> node with "ethernet" alias. Let's add the node so that U-Boot can do its
> business.
>
> Model B rev2 and Model B+ entries were verified by me, the hierarchy and
> pid/vid pair for the Version 2 was provided by Peter Chen. Original
> Model B is a blind shot, though very likely correct.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Acked-by: Stephen Warren <swarren@wwwdotorg.org>
> ---

Applied to bcm2835-dt-next locally.  We've already sent out pull
requests for 4.7, so I'll push it once 4.7-rc1 happens.

Thanks!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160502/5a998f3f/attachment-0001.sig>
