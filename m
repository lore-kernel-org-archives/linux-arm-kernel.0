From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Jul 2012 20:58:28 +0000
Subject: [GIT PULL] Samsung cleanup-2 for v3.6
In-Reply-To: <142c01cd639c$2f081800$8d184800$%kim@samsung.com>
References: <142c01cd639c$2f081800$8d184800$%kim@samsung.com>
Message-ID: <201207172058.28993.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 16 July 2012, Kukjin Kim wrote:
> Here is second Samsung cleanup pull request for v3.6.
> Please pull from: 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> next/cleanup-samsung-2
> 
> It is related in using common GPIO API and removing unused GPIOs.
> 
> If any problems, please let me know.
> 

Very nice series, I've merged it into next/cleanup now.

Two general comments on your submissions:

1. Please put the branch name into the same line as the git url, that
makes it slightly faster for me to copy-and-paste the pull location.

2. If you can, please use signed tags for your pull requests rather
than branch names. A signed tag means that you can write the text
for the merge changeset yourself so I don't have to do the description.
Ideally the signing key should have signatures from other people in the
keyring so everybody can check the authenticity of the request, but
just having the changelog there also helps.

	Arnd
