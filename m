From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 4 Jun 2012 08:29:33 +0100
Subject: [PATCH] slimbus: Linux driver framework for SLIMbus.
In-Reply-To: <4FCC280C.6030103@landley.net>
References: <1338340310-4473-1-git-send-email-sdharia@codeaurora.org>
 <4FCC280C.6030103@landley.net>
Message-ID: <20120604072933.GE26676@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 03, 2012 at 10:14:20PM -0500, Rob Landley wrote:
> On 05/29/2012 08:11 PM, Sagar Dharia wrote:

> > SLIMbus replaces many digital audio buses and control buses by
> > providing flexible and dynamic bus-bandwidth between data-functions
> > and control-functions.

> So that's a really long way of saying "A bit like I2C but faster"?

No, it's replacing I2S (or whatever) too.  Really it's much more like
USB than I2C.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120604/bff8061a/attachment.sig>
