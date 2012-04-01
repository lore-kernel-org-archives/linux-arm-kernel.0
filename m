From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 1 Apr 2012 15:29:20 +0100
Subject: [PATCH 1/2] clk: Fix comment for end of CONFIG_COMMON_CLK section
In-Reply-To: <20120401130216.GA24211@n2100.arm.linux.org.uk>
References: <1333279960-8497-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20120401130216.GA24211@n2100.arm.linux.org.uk>
Message-ID: <20120401142918.GA8971@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 01, 2012 at 02:02:16PM +0100, Russell King - ARM Linux wrote:
> On Sun, Apr 01, 2012 at 12:32:39PM +0100, Mark Brown wrote:
> > There is no else block so the #endif is for the end of the section for
> > CONFIG_COMMON_CLK.

> Get rid of the comment entirely.  For just a single level of ifdef it
> makes no sense.

That's actually my preference too, I was mostly just sticking with the
existing style.  I'll send out a version doing that shortly.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120401/b45390b8/attachment.sig>
