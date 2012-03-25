From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 25 Mar 2012 10:21:58 +0000
Subject: [GIT PULL 02/09] ARM: global cleanups
In-Reply-To: <1332626568-17812-3-git-send-email-arnd@arndb.de>
References: <1332626568-17812-1-git-send-email-arnd@arndb.de>
 <1332626568-17812-3-git-send-email-arnd@arndb.de>
Message-ID: <201203251021.59187.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 24 March 2012, Arnd Bergmann wrote:
> Quite a bit of code gets removed, and some stuff moved around, mostly
> the old samsung s3c24xx stuff. There should be no functional changes in
> this series otherwise. Some cleanups have dependencies on other arm-soc
> branches and will be sent in the second round.
> 
> The at91cap9 platform is removed and no longer listed in
> Documentation/feature-removal-schedule.txt, which conflicts with two
> new entries in that file.
> 
> arch/arm/plat-mxc/audmux-v1.c was removed, so the changes to its comments
> are meaningless now.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Hi Linus,

I've just had to update this tag again, the top commit is now 24d2e18,
this fixes a regression pointed out by Russell, which was introduced
in the cleanup branch but fixed in another commit that you have already
pulled. I've merged that branch into mine to keep this (more) bisectible.

	Arnd
