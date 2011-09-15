From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Sep 2011 17:32:59 +0200
Subject: [GIT PULL] Samsung Fixes for v3.1-rc7
In-Reply-To: <00b101cc738d$bcf46ce0$36dd46a0$%kim@samsung.com>
References: <00b101cc738d$bcf46ce0$36dd46a0$%kim@samsung.com>
Message-ID: <201109151732.59886.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 September 2011, Kukjin Kim wrote:
> This is Samsung fixes for v3.1
> 
> Please pull from:
>   git://github.com/kgene/linux-samsung.git samsung-fixes-2
> As you know, git.kernel.org/master.kernel.org has been down so I use
> temporary git repo. at github now.
> 
> These things are needed for v3.1 and if any problems, please let me know.
> 
> As a note, others for v3.2 will be sent in the next week...

Thanks, pulled.

Is it correct that you want none of these patches to be backported
into the stable or longterm releases? Some of these look like they
should be marked 'Cc: stable at kernel.org'.

	Arnd
