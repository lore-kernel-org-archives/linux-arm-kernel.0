From: eric@anholt.net (Eric Anholt)
Date: Thu, 18 Aug 2016 10:59:05 -0700
Subject: [PATCH v3 1/2] ARM: dts: Remove use of skeleton.dtsi from
 bcm283x.dtsi
In-Reply-To: <1471516926-11466-1-git-send-email-ijc@hellion.org.uk>
References: <1471516926-11466-1-git-send-email-ijc@hellion.org.uk>
Message-ID: <87zioaj6vq.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ian Campbell <ijc@hellion.org.uk> writes:

> This file is included from DTS files under arch/arm64 too (via
> broadcom/bcm2837-rpi-3-b.dts and broadcom/bcm2837.dtsi). There is a desire
> not to have skeleton.dtsi for ARM64. See commit 3ebee5a2e141 ("arm64: dts:
> kill skeleton.dtsi") for rationale for its removal.
>
> As well as the addition of #*-cells also requires adding the device_type to
> the rpi memory node explicitly.
>
> Note that this change results in the removal of an empty /aliases node from
> bcm2835-rpi-a.dtb and bcm2835-rpi-a-plus.dtb. I have no hardware to check
> if this is a problem or not.
>
> It also results in some reordering of the nodes in the DTBs (the /aliases
> and /memory nodes come later). This isn't supposed to matter but, again,
> I've no hardware to check if it is true in this particular case.
>
> Signed-off-by: Ian Campbell <ijc@hellion.org.uk>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Tested-by: Stefan Wahren <stefan.wahren@i2se.com>

I'd lost track of these patches, sorry.  Both are:

Acked-by: Eric Anholt <eric@anholt.net>

They're going through the -soc tree, right?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160818/9f75ca06/attachment.sig>
