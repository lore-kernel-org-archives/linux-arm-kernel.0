From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Sun, 23 Jan 2011 22:40:05 +0100
Subject: [PATCH] mmci: fixup broken_blockend variant patch v2
In-Reply-To: <20110123180110.GJ30094@n2100.arm.linux.org.uk>
References: <1295275071-13146-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTin67iTj34QBv3T-9+oMdo6q=EsYKf=5ca=6B69s@mail.gmail.com>
	<4D346800.3070603@stericsson.com>
	<20110118121455.GB9719@n2100.arm.linux.org.uk>
	<AANLkTineFJhqMcJbg1YQbPymT537Ef=jVgXLC5uw7DOt@mail.gmail.com>
	<20110119205158.GC6335@n2100.arm.linux.org.uk>
	<AANLkTimGmGStr8wHbJhkOsPcrWQmLFFQQCpgizE8+joj@mail.gmail.com>
	<AANLkTim4i8BibVFmn2C4ixRoMrX5mNU9HZjW2KGMXsYZ@mail.gmail.com>
	<20110123180110.GJ30094@n2100.arm.linux.org.uk>
Message-ID: <AANLkTiko9X_ua-ZAOZ-jEaAkPTKLCKyhgCHt6hbM5C-K@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/1/23 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Fri, Jan 21, 2011 at 01:53:06PM +0100, Linus Walleij wrote:

> If we're going to move away from the blockend IRQs to using the data
> counter, can we have a patch which switches the driver to use the data
> counter and then a followup patch which removes the broken blockend
> stuff, rather than somethign that changes the broken blockend stuff
> and then removes it?

6631/1 fixes the broken blockend stuff into a state that works,
then 6632/1 removes it in favor of using the MMCIDATACNT.

Then we have 6630/1, which is an unrelated change, fixing a bug
with suspend/resume.

Hope this helps.

Yours,
Linus Walleij
