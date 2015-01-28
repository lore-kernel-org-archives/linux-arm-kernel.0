From: hch@lst.de (Christoph Hellwig)
Date: Wed, 28 Jan 2015 17:55:36 +0100
Subject: [PATCH] mtd: export new mtd_mmap_capabilities
In-Reply-To: <1900951.4yX9yJNQM5@wuerfel>
References: <1900951.4yX9yJNQM5@wuerfel>
Message-ID: <20150128165536.GA17313@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 28, 2015 at 04:19:31PM +0100, Arnd Bergmann wrote:
> The recently added mtd_mmap_capabilities can be used from loadable
> modules, in particular romfs, but is not exported, so we get
> 
> ERROR: "mtd_mmap_capabilities" [fs/romfs/romfs.ko] undefined!
> 
> This adds the missing export.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: b4caecd48005f ("fs: introduce f_op->mmap_capabilities for nommu mmap support")

Thanks, this looks fine to me:

Acked-by: Christoph Hellwig <hch@lst.de>
