From: eric@anholt.net (Eric Anholt)
Date: Mon, 22 Aug 2016 10:57:13 -0700
Subject: [PATCH V3 2/5] ARM: dts: bcm283x: Add dtsi for USB host mode
In-Reply-To: <1471792204-21908-3-git-send-email-stefan.wahren@i2se.com>
References: <1471792204-21908-1-git-send-email-stefan.wahren@i2se.com>
 <1471792204-21908-3-git-send-email-stefan.wahren@i2se.com>
Message-ID: <87fupw4rgm.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <stefan.wahren@i2se.com> writes:

> In case dr_mode isn't passed via DT, the dwc2 defaults to OTG mode.
> But all Raspberry Pi boards here are designed only for host mode.
> So fix this issue by providing a dtsi file which set the dr_mode
> to host.

Can you explain what change this should cause for these boards?  Is it
just going to drop this message from dmesg:

dwc2 3f980000.usb: Configuration mismatch. dr_mode forced to host

or something else?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160822/7c8ce84d/attachment.sig>
