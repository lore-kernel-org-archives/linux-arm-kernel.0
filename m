From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 5 Jul 2011 13:51:26 +0200
Subject: [PATCH 8/8] ARM: S5PV210: example of CMA private area for FIMC
	device on Goni board
In-Reply-To: <1309851710-3828-9-git-send-email-m.szyprowski@samsung.com>
References: <1309851710-3828-1-git-send-email-m.szyprowski@samsung.com>
	<1309851710-3828-9-git-send-email-m.szyprowski@samsung.com>
Message-ID: <201107051351.26634.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 July 2011, Marek Szyprowski wrote:
> 
> This patch is an example how device private CMA area can be activated.
> It creates one CMA region and assigns it to the first s5p-fimc device on
> Samsung Goni S5PC110 board.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
