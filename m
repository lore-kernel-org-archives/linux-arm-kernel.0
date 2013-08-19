From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 Aug 2013 10:03:39 +0200
Subject: [RFC v1 0/5] ARM: Initial support for Marvell Armada 1500
In-Reply-To: <521156EF.3090201@gmail.com>
References: <1376682098-10580-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <201308172132.59402.arnd@arndb.de> <521156EF.3090201@gmail.com>
Message-ID: <201308191003.39528.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 19 August 2013, Sebastian Hesselbarth wrote:
> We either put it into mach-mvebu and pretend to consolidate Marvell SoCs
> in there. Pro would be that it is close to other Armadas there, con is
> that Armada is codename for virtually any Marvell SoC lately.
> 
> If we want a new mach- directory, I'd suggest either mach-berlin which
> looks like some nickname for 88de3xxx SoCs or simply boring
> mach-88de3xxx.

As I said, either way is fine with me. If you use a new directory, I'd
suggest using the same mach-mv88de3100 name that Marvell uses, to give
them a "hint" about this when updating their own sources to a newer
version. They might get the idea and actually start using your code ;-)

	Arnd
