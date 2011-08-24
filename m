From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 24 Aug 2011 16:35:52 +0200
Subject: [PATCH 1/2] ARM: L2X0: add explicit cpu_relax() for busy wait loop
In-Reply-To: <1314149411-5063-1-git-send-email-Baohua.Song@csr.com>
References: <1314149411-5063-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <201108241635.52502.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 24 August 2011, Barry Song wrote:
> using cpu_relax in busy loops is a well-known idiom in the kernel. It's more
> for documentation purposes than technically needed here.
> 
> Cc: Jamie Iles <jamie@jamieiles.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
