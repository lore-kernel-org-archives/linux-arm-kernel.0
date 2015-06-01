From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 1 Jun 2015 11:49:19 +0200
Subject: [PATCH] fix n900 dts file to work around 4.1 touchscreen
 regression on n900
In-Reply-To: <20150530101430.GA505@amd>
References: <20150527132545.GA23434@amd> <20150527133311.GJ30798@pali>
 <20150527143722.GA28108@amd> <20150527145837.GA13223@earth>
 <20150529190816.GA20232@amd> <20150529192505.GA28987@amd>
 <20150529193211.GA7599@amd>
 <20150529194955.GV2026@saruman.tx.rr.com>
 <20150529200306.GB17267@lukather> <20150530101430.GA505@amd>
Message-ID: <20150601094919.GG17267@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 30, 2015 at 12:14:30PM +0200, Pavel Machek wrote:
> Well... the driver was not broken... before you did "cleanup" that did
> two functional changes. And yes, the dts should be fixed, but that
> does not make your "cleanup" good.

Whether it's good or not is arguable, and it really boils down to what
we consider the default value when properties are missing.

If it's 0, then my code does the right thing. If it's undefined, well,
I'd expect undefined behaviour to change without any notice.

Feel free to suggest any better solution.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150601/ed3687f0/attachment.sig>
