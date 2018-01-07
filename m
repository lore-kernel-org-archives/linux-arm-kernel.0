From: eric@anholt.net (Eric Anholt)
Date: Sun, 07 Jan 2018 14:08:23 -0800
Subject: [PATCH] Revert "ARM: dts: bcm283x: Fix DTC warnings about missing
 phy-cells"
In-Reply-To: <1515332212-23593-1-git-send-email-stefan.wahren@i2se.com>
References: <1515332212-23593-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <87incdjp9k.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <stefan.wahren@i2se.com> writes:

> This reverts commit 014d6da6cb2525d7f48fb08c705cb130cc7b5f4a.
>
> The DT clean up could trigger an endless deferred probe of DWC2 USB driver
> on the Raspberry Pi 2/3. So revert the change until we fixed the probing
> issue.

Why's that?  I found that I needed to enable the generic no-op phy
driver, but other than that it was fine.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180107/0a765b0b/attachment.sig>
