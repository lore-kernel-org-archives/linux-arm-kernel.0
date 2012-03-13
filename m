From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Mar 2012 09:58:30 +0000
Subject: [PATCH 7/7] ARM: kirkwood: use devicetree for rtc-mv
In-Reply-To: <92d02581e0fce75f84d61edf55678108237e881a.1331601448.git.jason@lakedaemon.net>
References: <cover.1331601448.git.jason@lakedaemon.net>
 <92d02581e0fce75f84d61edf55678108237e881a.1331601448.git.jason@lakedaemon.net>
Message-ID: <201203130958.31223.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 March 2012, Jason Cooper wrote:
> 
> Signed-off-by: Jason Cooper <jason@lakedaemon.net>
> ---
>  arch/arm/boot/dts/kirkwood.dtsi   |    6 ++++++
>  arch/arm/mach-kirkwood/board-dt.c |    1 -
>  arch/arm/mach-kirkwood/common.c   |    2 +-
>  arch/arm/mach-kirkwood/common.h   |    1 -
>  4 files changed, 7 insertions(+), 3 deletions(-)
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>

I think you can just merge this with patch 6, as they are two halves
of the same work.

	Arnd
