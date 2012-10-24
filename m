From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 24 Oct 2012 12:07:56 +0000
Subject: [PATCH v3 4/5] ARM: annotate VMALLOC_END definition with _AC
In-Reply-To: <20121024003502.GE31625@beefymiracle.amer.corp.natinst.com>
References: <20121024003502.GE31625@beefymiracle.amer.corp.natinst.com>
Message-ID: <201210241207.56415.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 24 October 2012, Josh Cartwright wrote:
> This makes the definition of VMALLOC_END suitable for use within
> assembly code.  This is necessary to allow the use of VMALLOC_END in
> defining where the early uart is mapped for use with DEBUG_LL.
> 
> Signed-off-by: Josh Cartwright <josh.cartwright@ni.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
