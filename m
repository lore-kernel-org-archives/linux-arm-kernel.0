From: simon.horman@netronome.com (Simon Horman)
Date: Tue, 1 Mar 2016 09:13:42 +0900
Subject: [PATCH] asm-generic: remove old nonatomic-io wrapper files
In-Reply-To: <1456496980-1852604-1-git-send-email-arnd@arndb.de>
References: <1456496980-1852604-1-git-send-email-arnd@arndb.de>
Message-ID: <20160301001338.GA14413@vergenet.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 26, 2016 at 03:29:05PM +0100, Arnd Bergmann wrote:
> The two header files got moved to include/linux, and most
> users were already converted, this changes the remaining drivers
> and removes the files.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/dma/idma64.h                                | 2 +-
>  drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c | 2 +-
>  drivers/net/ethernet/netronome/nfp/nfp_net.h        | 2 +-

The NFP portion:

Acked-by: Simon Horman <simon.horman@netronome.com>

>  include/asm-generic/io-64-nonatomic-hi-lo.h         | 2 --
>  include/asm-generic/io-64-nonatomic-lo-hi.h         | 2 --
>  5 files changed, 3 insertions(+), 7 deletions(-)
>  delete mode 100644 include/asm-generic/io-64-nonatomic-hi-lo.h
>  delete mode 100644 include/asm-generic/io-64-nonatomic-lo-hi.h
