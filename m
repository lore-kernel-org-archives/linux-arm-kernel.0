From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 11 Dec 2012 22:38:19 +0000
Subject: [PATCH V3] ARM: bcm281xx: Add timer driver
In-Reply-To: <50C7993B.4070201@wwwdotorg.org>
References: <1355250387-622-1-git-send-email-csd@broadcom.com>
 <50C785DD.8030407@broadcom.com> <50C7993B.4070201@wwwdotorg.org>
Message-ID: <201212112238.19528.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 11 December 2012, Stephen Warren wrote:
> Olof, Arnd, that brings me to the question of:
> 
> Should I:
> 
> a) Add that branch into linux-next (e.g. via the Tegra tree's for-next)
> right after v3.8-rc1, let is sit there for a week or two (to allow
> rebasing to squash in any fixes that show up as being needed), and then
> send a pull request to arm-soc as a stable branch,
> 
> or:
> 
> b) Send a pull request to arm-soc right after 3.8-rc1, and let you do
> any rebasing/squashing needed, before declaring it stable say around
> 3.8-rc2 or 3.8-rc3?

I think either way works fine. The first one is less work for us though ;-)

	Arnd
