From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 22 Dec 2015 09:17:53 +1100
Subject: [PATCH] orangefs: fix typo in ornagefs_inode_lock
In-Reply-To: <1450705769-17712-1-git-send-email-arnd@arndb.de>
References: <1450705769-17712-1-git-send-email-arnd@arndb.de>
Message-ID: <20151222091753.0896d1b2@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Mon, 21 Dec 2015 14:49:29 +0100 Arnd Bergmann <arnd@arndb.de> wrote:
>
> Orangefs fails to build on 32-bit SMP configurations due to a simple
> misspelling, this does the obvious fix.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 575e946125f7 ("Orangefs: change pvfs2 filenames to orangefs")

I will add this to linux-next as a merge fix for the orangefs tree today.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
