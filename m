From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 2 Apr 2012 18:19:16 +0100
Subject: [PATCH/RFC v2] ARM: amba: Remove AMBA level regulator support
In-Reply-To: <20120402165742.GD24211@n2100.arm.linux.org.uk>
References: <1333306720-28344-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <CACRpkdYRStgKo_e-4kZKA-V-OoMiV21jRS3R4g1Cq+4c+4=iQA@mail.gmail.com>
 <CAH+eYFC+q4xFuSdRBkO9nb0XZWU4pQ_yCyinMy2X3ds9WQd1kw@mail.gmail.com>
 <CACRpkda2zh=zR+A9bwhRXYHtQdFeUpiqG4d5g1i82mPCs1mXaQ@mail.gmail.com>
 <20120402101427.GA3172@opensource.wolfsonmicro.com>
 <20120402104357.GB24211@n2100.arm.linux.org.uk>
 <20120402113413.GA7560@opensource.wolfsonmicro.com>
 <20120402165742.GD24211@n2100.arm.linux.org.uk>
Message-ID: <20120402171916.GG15197@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 02, 2012 at 05:57:42PM +0100, Russell King - ARM Linux wrote:

> ARM PRIMECELL BUS SUPPORT
> M:      Russell King <linux@arm.linux.org.uk>
> S:      Maintained
> F:      drivers/amba/
> F:      include/linux/amba/bus.h

> not provide enough clues?  Should I delete all my entries in that file
> because the only people who look in there are spammers when the file is
> published on the web?

I did look in there and also in the git history which shows the same
information, hence my CCing you.  Linus introduced some doubt into my
mind that this might be something that went through arm-soc now rather
than via your tree even if you are still maintaining it as no specific
git tree or anything is mentioned there.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120402/0df36727/attachment.sig>
