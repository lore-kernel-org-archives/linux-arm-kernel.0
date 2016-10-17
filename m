From: eric@anholt.net (Eric Anholt)
Date: Mon, 17 Oct 2016 09:58:39 -0700
Subject: [PATCH v4 2/7] ARM: dts: bcm283x: Define standard pinctrl groups
 in the gpio node.
In-Reply-To: <1474274603-24215-3-git-send-email-kraxel@redhat.com>
References: <1474274603-24215-1-git-send-email-kraxel@redhat.com>
 <1474274603-24215-3-git-send-email-kraxel@redhat.com>
Message-ID: <87shrukj40.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gerd Hoffmann <kraxel@redhat.com> writes:

> From: Eric Anholt <eric@anholt.net>
>
> The BCM2835-ARM-Peripherals.pdf documentation specifies what the
> function selects do for the pins, and there are a bunch of obvious
> groupings to be made.  With these created, we'll be able to replace
> bcm2835-rpi.dtsi's main "set all of these pins to alt0" with
> references to specific groups we want enabled.
>
> Also add pinctrl groups for emmc and sdhost.
>
> Based on patches by Eric Anholt <eric@anholt.net>

I amended this line to "Based on patches by Eric Anholt, with fixups by
Gerd Hoffmann." to explain why it had me as author but you in signoff.

I had to resolve some conflicts on the way in because apparently you had
built this against a tree with 14 and 15 already dropped from alt0.  I
think those resolutions were sufficiently mechanical that it didn't
merit a respin.

Merged the series to bcm2835-dt-next.  Thanks for getting this done!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161017/8fe3d040/attachment.sig>
