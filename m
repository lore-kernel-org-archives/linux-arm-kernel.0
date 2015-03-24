From: broonie@kernel.org (Mark Brown)
Date: Tue, 24 Mar 2015 10:01:13 -0700
Subject: [PATCH 5/7] ARM: dts: enable regulator support for i.MX23/i.MX28
In-Reply-To: <55110813.7010708@i2se.com>
References: <1426984203-9133-1-git-send-email-stefan.wahren@i2se.com>
 <1426984203-9133-6-git-send-email-stefan.wahren@i2se.com>
 <20150323060706.GB4946@pengutronix.de>
 <1469391177.549604.1427133274978.JavaMail.open-xchange@oxbaltgw02.schlund.de>
 <20150323183740.GI14954@sirena.org.uk> <55110813.7010708@i2se.com>
Message-ID: <20150324170113.GO17265@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 24, 2015 at 07:45:39AM +0100, Stefan Wahren wrote:
> Am 23.03.2015 um 19:37 schrieb Mark Brown:

> > This might be the sort of thing normally handled by a system controller,
> > I have to say I had assumed this had all been discussed in the previous
> > iterations of this seriee.

> sorry, but i missed this important fact.

> If you speak of system controller, do you mean the usage of
> drivers/mfd/syscon.c ?

Yes.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150324/14a7e477/attachment.sig>
