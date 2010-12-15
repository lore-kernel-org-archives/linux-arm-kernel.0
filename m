From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Dec 2010 17:40:24 +0100
Subject: [PATCH 1/7] msm: io: I/O register definitions for MSM8960
In-Reply-To: <20101215153540.GA15817@huya.qualcomm.com>
References: <1292384961-8851-1-git-send-email-stepanm@codeaurora.org>
	<201012151631.11574.arnd@arndb.de>
	<20101215153540.GA15817@huya.qualcomm.com>
Message-ID: <201012151740.24933.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 15 December 2010, David Brown wrote:
> 
> On Wed, Dec 15, 2010 at 04:31:11PM +0100, Arnd Bergmann wrote:
> > On Wednesday 15 December 2010, Stepan Moskovchenko wrote:
> 
> > In this particular case, it's rather confusing, because one would assume
> > that MSM8960 is a subset of MSM8X60!
> 
> Unfortunately, this is not the case, and I'm not sure what better name
> to use for MSM8X60.  The MSM8X60 name covers MSM8260 and MSM8660, but
> MSM8960 is quite a bit different.  Any ideas for better names?

No, you probably lose there, unless you can fall back to code names
instead of product numbers.

My point was really that they should not be exclusive, even if they
are rather different. If the code is structured in a more modular
way, you can turn all MSM/QSD options from the "Qualcomm MSM SoC Type"
choice into separate "bool" config options. You probably don't want
to do that now for all the existing ones, but I would suggest you
try not add more to the pile ;-).

	Arnd
