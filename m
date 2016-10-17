From: eric@anholt.net (Eric Anholt)
Date: Mon, 17 Oct 2016 10:29:18 -0700
Subject: [PATCH V3 RFT 3/5] ARM64: dts: bcm283x: Use dtsi for USB host mode
In-Reply-To: <1471792204-21908-4-git-send-email-stefan.wahren@i2se.com>
References: <1471792204-21908-1-git-send-email-stefan.wahren@i2se.com>
 <1471792204-21908-4-git-send-email-stefan.wahren@i2se.com>
Message-ID: <87lgxmkhox.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <stefan.wahren@i2se.com> writes:

> In case dr_mode isn't passed via DT, the dwc2 driver defaults
> to OTG mode. But the Raspberry Pi 3 is designed only for host mode.
> So fix this issue by linking to the dtsi file which set the dr_mode
> to host.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Applied Gerd's Tested-by and merged to bcm2835-dt-64-next.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161017/1eb7a5d5/attachment.sig>
