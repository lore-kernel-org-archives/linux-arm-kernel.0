From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 12 Mar 2011 11:00:36 +0100
Subject: [PATCH 08/10] ux500: hooking up netdev and digio to compilation.
In-Reply-To: <1299884892-6766-9-git-send-email-mathieu.poirier@linaro.org>
References: <1299884892-6766-1-git-send-email-mathieu.poirier@linaro.org>
	<1299884892-6766-9-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <201103121100.36641.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 12 March 2011 00:08:10 mathieu.poirier at linaro.org wrote:
> From: Mathieu J. Poirier <mathieu.poirier@linaro.org>
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  arch/arm/mach-ux500/Makefile |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)

It's better to patch the Makefile in the same patch that
adds the file, splitting this in the way you do has no
benefit but makes both patches useless by themselves.

	Arnd
