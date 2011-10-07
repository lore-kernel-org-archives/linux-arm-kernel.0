From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 7 Oct 2011 20:05:49 +0200
Subject: [GIT PULL] Samsung cleanup-2 for v3.2
In-Reply-To: <019a01cc8298$823f7b20$86be7160$%kim@samsung.com>
References: <019a01cc8298$823f7b20$86be7160$%kim@samsung.com>
Message-ID: <201110072005.49967.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 04 October 2011, Kukjin Kim wrote:
> This is second cleanup for Samsung stuff for v3.2 and includes cleanup
> header files in plat-s3c24xx and plat-s5p to merge into one plat-samsung
> directory.
> 
> Please pull from:
>   git://github.com/kgene/linux-samsung.git next-samsung-cleanup-2
> 
> And this is based on previous Samsung cleanup branch, next-samsung-cleanup
> which has been merged in arm-soc because of dependency.
> 
> If any problems, please let me know.
> 

Looks good to me. I think this should go into 3.2 very late during the merge
window since it moves around a lot of files that might be touched by other
patches, and I don't want to break a lot of that stuff, so I'm putting
it into a separate next/cleanup2 branch, ok?

	Arnd
