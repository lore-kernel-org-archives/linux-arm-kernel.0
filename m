From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 30 May 2012 19:13:40 +0100
Subject: [PATCH] slimbus: Linux driver framework for SLIMbus.
In-Reply-To: <1338340310-4473-1-git-send-email-sdharia@codeaurora.org>
References: <1338340310-4473-1-git-send-email-sdharia@codeaurora.org>
Message-ID: <20120530181340.GT9947@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2012 at 07:11:33PM -0600, Sagar Dharia wrote:
> SLIMbus (Serial Low Power Interchip Media Bus) is a specification
> developed by MIPI (Mobile Industry Processor Interface) alliance.

This patch is about 150k which is rather large to review.  It would be
enormously helpful for review if it could be broken down into a patch
series.  For example, things like the device registration could be
broken out into a separate patch as could the core bus operations and
things like the clocking/bandwidth management.

I've not actually looked through the patch yet, partly because doing it
all in one sitting will take some time.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120530/b2d4b17a/attachment.sig>
