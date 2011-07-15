From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Jul 2011 16:32:06 +0200
Subject: [GIT PULL] ARM: Cavium CNS3xxx updates for 3.1
In-Reply-To: <20110714171053.GA8580@oksana.dev.rtsoft.ru>
References: <20110714171053.GA8580@oksana.dev.rtsoft.ru>
Message-ID: <201107151632.06548.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 14 July 2011, Anton Vorontsov wrote:
> Please pull linux-cns3xxx.git tree to receive updates for CNS3xxx.
> There are just two patches: the first patch corrects CPU type, and
> the second adds L2 cache controller support, which doubles the
> performance.
> 
> For the second patch, I fixed all the comments, plus added some
> notes regarding why we don't want to select CACHE_PL310 for CNS3xxx.
> 
> For convenience' sake I inline the patches here, they're pretty
> small.

Pulled, thanks!

	Arnd
