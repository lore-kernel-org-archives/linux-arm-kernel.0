From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 07 Jan 2016 15:59:26 +0100
Subject: [PATCH] efi: stub: define DISABLE_BRANCH_PROFILING for all
 architectures
In-Reply-To: <20160106154348.GF16580@arm.com>
References: <1450862968-20222-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160105175114.GG10705@arm.com> <20160106154348.GF16580@arm.com>
Message-ID: <14896110.p9g5zCmDvk@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 January 2016 15:43:49 Will Deacon wrote:
> On Tue, Jan 05, 2016 at 05:51:14PM +0000, Will Deacon wrote:
> > I can take this via the arm64 tree, unless Arnd wants to queue it in
> > arm-soc. Arnd?

arm64 tree is fine with me.
 
> Given that this fixes build errors, I've applied it in the arm64 tree,
> so it should appear in -next soon.
> 

Thanks,

	Arnd
