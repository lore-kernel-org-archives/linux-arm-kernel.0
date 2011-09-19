From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 19 Sep 2011 19:42:30 +0100
Subject: Link failures due to __bug_table in current -next
In-Reply-To: <20110919184027.GZ16381@n2100.arm.linux.org.uk>
References: <20110919120954.GA20314@opensource.wolfsonmicro.com>
	<20110919184027.GZ16381@n2100.arm.linux.org.uk>
Message-ID: <20110919184230.GF540@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2011 at 07:40:27PM +0100, Russell King - ARM Linux wrote:
> On Mon, Sep 19, 2011 at 01:09:54PM +0100, Mark Brown wrote:

> > I'm wondering if we need something like 7c8a25 (CRIS: Discard exit.text
> > and .data at runtime) but figuring it out is a bit beyond my ld skills
> > right now.

> fatal: ambiguous argument '7c8a25': unknown revision or path not in the working
> tree.

> Maybe you could be more specific?

It's in -next as of today, presumably it comes from the CRIS tree.  I
didn't look too closely once the revert worked for me.
