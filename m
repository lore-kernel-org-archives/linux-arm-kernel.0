From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 21 Jul 2011 11:55:41 -0700
Subject: [PATCH 2/2] MTD: pxa3xx_nand: Fix blank page ECC mismatch
In-Reply-To: <BANLkTi=7f2+LK32p6WG1doXzYWGf1wJQJQ@mail.gmail.com>
References: <1307440867-18993-1-git-send-email-leiwen@marvell.com>
	<1307440867-18993-2-git-send-email-leiwen@marvell.com>
	<1307445467.11104.80.camel@localhost>
	<BANLkTin_Z8ndAjp9vw6QcNb5bT82uoR9ng@mail.gmail.com>
	<BANLkTi=7f2+LK32p6WG1doXzYWGf1wJQJQ@mail.gmail.com>
Message-ID: <CAN8TOE8n_+FBr3_6fCTpM4Sp80ShWHftP9YsGqYsCT9T6-Pytw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 25, 2011 at 4:48 AM, Daniel Mack <zonque@gmail.com> wrote:
> Has anyone queued this for 3.0 yet? This fixes a serious regression,
> so we need this merged, along with Lei's other patch titled "MTD:
> pxa3xx_nand: fix nand detection issue".

Hmm, I'm a little late on this one...I was just sorting through a few
e-mails and saw this one.

It looks like it made it as far as Artem's l2-mtd-2.6.git:
http://git.infradead.org/users/dedekind/l2-mtd-2.6.git/commit/e119967aad8df3b87834e28249feca696c650647

but things have been sitting there for months now. I believe every so
often, dwmw sorts through Artem's l2-mtd-2.6 repo, pulls patches into
mtd-2.6, and gets them merged upstream. I think the last time this
happened was early June (between v3.0-rc1 and v3.0-rc2). Once such
patches hit mainline, then the stable team is alerted and the
appropriately-labeled patches are sent to the stable repos. Don't know
when this will happen though. I'm kinda wondering myself...

Brian
